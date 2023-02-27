//
//  OpenCVCameraManager.swift
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

import Foundation
import CoreImage
import OpenCVWrapper
import std.string


class OpenCvCameraViewModel: CGImageViewModel {
    
    override init() { }
    
    func startCapture() {
        var videoCapture = cv.VideoCapture(1, 0)
        var mat = cv.Mat()
        
        print(videoCapture.isOpened())
        
        Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { t in
            OpenCV.captureFrame(&videoCapture, &mat)
            self.current = mat.toCGImage()
        }
        
        
    }
    
}
