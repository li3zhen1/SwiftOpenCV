//
//  OpenCVCameraManager.swift
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

import Foundation
import CoreImage
import OpenCVWrapper

class OpenCvCameraManager {
    @Published var currentImage: CGImage?
    @Published var error: Error?
    
    init() {
        
    }
    
    func startCapture() {
        var videoCapture = cv.VideoCapture()
        
        var imgMat = cv.Mat()
        videoCapture.read(imgMat as! cv.OutputArray)
    }
}
