//
//  VisionSDK.swift
//  VisionAppSDK
//
//  Created by ramil on 26.03.2022.
//

import Foundation
import Vision
import UIKit

public class VisionSDK {
    
    public init() {}
    
    public func getRecognizedText(image: UIImage) {
        
        // Get the CGImage on which to perform requests.
        guard let cgImage = image.cgImage else { return }
        
        // Create a new image-request handler.
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        // Create a new request to recognize text.
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        
        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
    
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
                    return
                }
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        
        print("Recognized text: \(recognizedStrings)")
    }
}
