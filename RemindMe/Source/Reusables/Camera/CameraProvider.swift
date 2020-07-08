//
//  CameraProvider.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

enum CameraProviderError: Error {
    case deviceUnavailable
    case deviceInputFailed
    case videoOutputFailed
}

class CameraProvider {
    let captureSession: AVCaptureSession
    let previewLayer: AVCaptureVideoPreviewLayer
    
    // MARK: - Initializer
    init() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        self.captureSession = captureSession
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        self.previewLayer = previewLayer
    }
    
    // MARK: - Prepare Camera
    
    func configureCamera(completion: @escaping (AVCaptureVideoPreviewLayer?, CameraProviderError?) -> Void) {
        
        DispatchQueue(label: "CameraProvider").async { [weak self] in
            var previewLayer: AVCaptureVideoPreviewLayer? = nil
            var error: CameraProviderError? = nil
            
            defer {
                DispatchQueue.main.async {
                    completion(previewLayer, error)
                }
            }
            
            // configure the device
            guard let backCamera = AVCaptureDevice.default(for: .video) else{
                error = CameraProviderError.deviceUnavailable
                return
            }
            
            // configure input
            guard let input = try? AVCaptureDeviceInput(device: backCamera) else {
                error = CameraProviderError.deviceInputFailed
                return
            }
            
            self?.captureSession.addInput(input)
            self?.captureSession.startRunning()
            
            if let preview = self?.previewLayer {
                previewLayer = preview
                error = nil
            } else {
                error = CameraProviderError.videoOutputFailed
            }
        }
    }
    
}
