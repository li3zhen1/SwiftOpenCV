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


func getHeadlineText(text: String, color: NSColor, font: NSFont.TextStyle) -> AttributedString {
    let a1: [NSAttributedString.Key: Any] = [
        .foregroundColor: color,
        .font: NSFont.preferredFont(forTextStyle: font),
    ]
    
    let s = NSMutableAttributedString(string: "1800013025 李臻 😀", attributes: a1)
    
    return AttributedString(s)
}

func getTextImage(text: String, width: Int, height: Int) -> CGImage? {
    
    
    let attrStr = getHeadlineText(text: text, color: .white, font: .largeTitle)
    
    let line = CTLineCreateWithAttributedString(NSAttributedString(attrStr))
    
    guard let context =  CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGImageByteOrderInfo.orderDefault.rawValue) else { return nil }
    
    
    
    CTLineDraw(line, context)
    
    return context.makeImage()
}



class OpenCVMediaViewModel: CGImageViewModel {
    
    private var playing = false
    private var timer: Timer?
    private var videoCapture: cv.VideoCapture?
    
    private var context: CGContext?
    
    
    let textImage = getTextImage(text: "1800013025 李臻 😀", width: 500, height: 500)?.toCvMat(alphaExist: true)
    
    func stopLooping() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
//    func appendTextToImage(mat: cv.Mat) -> cv.Mat{
//        return OpenCV.addWeighted(mat, textImage!)
//    }
//
    func loadMedia(_ url: URL, _ text: String? = nil) -> Bool {
        self.stopLooping()
        
        videoCapture = OpenCV.VideoCapture(url.path().cString(using: .ascii))
        var mat = cv.Mat()
        
        
        if imageExtension.contains(url.pathExtension) {
            OpenCV.captureFrame(&self.videoCapture!, &mat)
            
            self.current = mat.toCGImage()
            
            return true
        }
        else if videoExtension.contains(url.pathExtension) {
            let fps = videoCapture?.get(OpenCV.CAP_PROP_FPS) ?? 60
            timer = Timer.scheduledTimer(withTimeInterval: 1.0/fps, repeats: true, block: { t in
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

