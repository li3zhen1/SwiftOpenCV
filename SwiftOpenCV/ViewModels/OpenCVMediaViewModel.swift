//
//  OpenCVMediaViewModel.swift
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

import Foundation
import AppKit
import OpenCVWrapper

enum MediaKind: Int {
    case video = 1
    case image = 2
}

let testImageUrl = "/Users/lizhen/Downloads/FoD7ONHXwAIGrr6.jpeg"

let testVideoUrl = "/Users/lizhen/Movies/Screen Recording 2023-02-27 at 22.58.20.mov"

let imageExtension = ["jpg", "jpeg" , "png", "webp", "bmp"]
let videoExtension = ["mp4", "mov"]

class OpenCVMediaViewModel: CGImageViewModel {
    
    //    @Published private var url: URL?
    //    @Published private var kind: MediaKind?
    
    private var playing = false
    private var timer: Timer?
    private var videoCapture: cv.VideoCapture?
    
    
    func stopLooping() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
//    func appendTextToMat(_ mat: inout cv.Mat, _ cgImage: CGImage, _ text: String ) {
//        let attributedString = AttributedString(text).
//        let line = CTLineCreateWithAttributedString(attributedString)
//
//        let context = CGContext(data: nil, width: Int(mat.cols), height: Int(mat.rows), bitsPerComponent: cgImage.bytesPerRow, bytesPerRow: cgImage.bytesPerRow, space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo)
//        let tst = attributedString.boundingRect(with: NSS, options: <#T##NSStringDrawingOptions#>)
//        attributedString.draw(with: NSRect(x: 0, y: 0, width: 200, height: 200), options: [], context: NSGraphicsContext(cgContext: context, flipped: false))
//    }
    
    func loadMedia(_ url: URL, _ text: String? = nil) -> Bool {
        self.stopLooping()
        
        videoCapture = OpenCV.VideoCapture(url.path().cString(using: .ascii))
        var mat = cv.Mat()
        
        
        if imageExtension.contains(url.pathExtension) {
            OpenCV.captureFrame(&self.videoCapture!, &mat)
            if let text {
                OpenCV.putText(&mat, text)
            }
            current = mat.toCGImage()
            return true
        }
        else if videoExtension.contains(url.pathExtension) {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0/60, repeats: true, block: { t in
                if var vc = self.videoCapture {
                    OpenCV.captureFrame(&vc, &mat)
                    
                    if let text { OpenCV.putText(&mat, text) }
                    
                    if let cgImage = mat.toCGImage() {
                        self.current = cgImage
                    }
                    else {
                        self.stopLooping()
                    }
                }
            })
            return true
        }
        else {
            return false
        }
    }
    
}

