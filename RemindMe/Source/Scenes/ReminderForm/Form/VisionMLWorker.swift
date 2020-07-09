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
    case mobileNetV2 = "MobileNetV2"
    case resnet50 = "Resnet50"
    
    var model: MLModel {
        switch self {
        case .mobileNetV2:
            return MobileNetV2().model
        case .resnet50:
            return Resnet50().model
        }
    }
}

enum VisionMLClassificationError : Error {
    case invalidModelFile
    case invalidImageFile
    case classificationFailed
}

class VisionMLWorker {
    let coreModel : VNCoreMLModel
    var classificationRequest: VNCoreMLRequest?

    /// Use the Swift class `MobileNetV2` Core ML generates from the model.
    /// To use a different Core ML classifier model, see
    /// https://developer.apple.com/machine-learning/models/
    /// - Parameter modelFile: A type of available file
    /// - Throws: A type of VisionMLClassificationError
    init(modelFile: CoreMLModelFile) throws {
        do {
            let model = modelFile.model
            let coreModel = try VNCoreMLModel(for: model)
            self.coreModel = coreModel
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
                            completionHandler: ([String]) -> Void) throws {
        
        guard let classificationRequest = self.classificationRequest else {
            Log.debug("Failed to perform classification.")
            throw VisionMLClassificationError.classificationFailed
        }
        
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
            Log.error("Unable to classify image.\n\(error?.localizedDescription)")
            return
        }
        
        let classification = classifications.first
        print(classification?.identifier)
        print(classification?.confidence)
    }
    
}
