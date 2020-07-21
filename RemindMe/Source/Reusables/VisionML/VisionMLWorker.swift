//
//  VisionMLWorker.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import Vision
import UIKit
import CoreML

enum CoreMLModelFile: String {
    case mobileNetV2    = "MobileNetV2"
    case resnet50       = "Resnet50"
    
    func getModel() throws -> MLModel {
        // use model default configurations
        let config = MLModelConfiguration()
        switch self {
        case .mobileNetV2:
            return try MobileNetV2(configuration: config).model
        case .resnet50:
            return try Resnet50(configuration: config).model
        }
    }
}

enum VisionMLClassificationError : Error {
    case invalidModelFile
    case invalidImageFile
    case classificationFailed
}

struct ClassificationData {
    let identifier: String
    let confidence: Double
}

typealias ClassificationCompletionHandler = (([ClassificationData]) -> Void)

class VisionMLWorker {
    let coreModel : VNCoreMLModel
    private(set) var classificationRequest: VNCoreMLRequest?
    /// Restricts classification prediction results count to just 1 by default.
    var classificationsCount: Int = 1
    var completionHandler: ClassificationCompletionHandler? = nil
    
    // MARK: - Initializer

    /// Use the Swift class `MobileNetV2` Core ML generates from the model.
    /// To use a different Core ML classifier model, see
    /// https://developer.apple.com/machine-learning/models/
    /// - Parameter modelFile: A type of available file
    /// - Throws: A type of VisionMLClassificationError
    init(modelFile: CoreMLModelFile) throws {
        do {
            let model       = try modelFile.getModel()
            let coreModel   = try VNCoreMLModel(for: model)
            self.coreModel  = coreModel
        }
        catch {
            Log.fatal("Failed to load Vision ML model: \(error)")
            throw VisionMLClassificationError.invalidModelFile
        }
    }
    
    /// Create a classification request based on model file
    func setupClassificationRequest() {
        let coreModel = self.coreModel
        let request = VNCoreMLRequest(model: coreModel) { [weak self] request, error in
            self?.processClassifications(for: request, error: error)
        }
        request.imageCropAndScaleOption = .centerCrop
        self.classificationRequest = request
    }

    /// Use a image to process and determine its classification
    /// - Parameter image: A image file
    /// - Parameter completionHandler: Invoked after classification has completed
    /// - Throws: A type of VisionMLClassificationError
    func getClassifications(for image: UIImage,
                            completionHandler: @escaping ClassificationCompletionHandler) throws {
        
        guard let classificationRequest = self.classificationRequest else {
            Log.debug("Failed to perform classification.")
            throw VisionMLClassificationError.classificationFailed
        }
        
        // remember completion handler for later
        self.completionHandler = completionHandler
        
        // feed the orientation information since CGImage can't read UIImage orientation
        let imageOrientation = image.imageOrientation.rawValue
        guard let orientation = CGImagePropertyOrientation(rawValue: UInt32(imageOrientation)),
            let ciImage = CIImage(image: image) else {
                Log.fatal("Unable to create \(CIImage.self) from \(image).")
                throw VisionMLClassificationError.invalidImageFile
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage,
                                                orientation: orientation)
            do {
                try handler.perform([classificationRequest])
            }
            catch {
                // check VNCoreMLRequest's completion block for detailed error
                Log.error("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    private func processClassifications(for request: VNRequest, error: Error?) {
        guard let results = request.results,
            let classifications = results as? [VNClassificationObservation], !classifications.isEmpty else {
                Log.error("Unable to classify image.\n\(String(describing: error?.localizedDescription))")
                return
        }
        
        let firstClassifications = classifications.prefix(classificationsCount)
        var requestedClassifications = [ClassificationData]()
        firstClassifications.forEach { (observation) in
            let data = ClassificationData(identifier: observation.identifier,
                                          confidence: Double(observation.confidence))
            requestedClassifications.append(data)
        }
        Log.info("Fetched requested classifications: \(requestedClassifications)")
        completionHandler?(requestedClassifications)
    }
}
