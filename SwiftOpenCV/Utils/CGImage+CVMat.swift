//
//  CGImage+CVMat.swift
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

import Foundation
import CoreGraphics
import OpenCVWrapper


/// Convert cv::Mat to CGImage
/// See https://github.com/opencv/opencv/blob/4.7.0/modules/imgcodecs/src/apple_conversions.mm
extension cv.Mat {
    
    public func toCGImage() -> CGImage? {
        
        let rev = OpenCV.reverseChannels(self)
        
        let nsData = NSData(bytes: rev.data, length: step.p[0] * Int(rev.rows))
        
        let colorSpace = rev.elemSize() == 1 ? CGColorSpaceCreateDeviceGray() : CGColorSpaceCreateDeviceRGB()
        let alpha = rev.channels() == 4
        let bitmapInfo: CGBitmapInfo = ( alpha ? CGImageAlphaInfo.premultipliedLast : CGImageAlphaInfo.none).rawValue | CGImageByteOrderInfo.orderDefault.rawValue
        
        guard let provider = CGDataProvider(data: nsData) else { return nil }
        
        let cgImage = CGImage(width: Int(cols), height: Int(rows), bitsPerComponent: 8 * elemSize1(), bitsPerPixel: 8 * elemSize(), bytesPerRow: step.p[0], space: colorSpace, bitmapInfo: bitmapInfo, provider: provider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)
        
        return cgImage;
    }
    
    
    static func fromCGImage(_ image: CGImage, m _m: inout cv.Mat, alphaExist: Bool) -> cv.Mat? {
        
        var m = OpenCV.reverseChannels(_m)
        
        guard var colorSpace = image.colorSpace else {return nil}
        
        let cols = image.width, rows = image.height
        
        
        var bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedLast.rawValue
        
        let context: CGContext?
        
        if colorSpace.model == .monochrome {
            m.createMutating(Int32(rows), Int32(cols), OpenCV.u8c1)
        
            if !alphaExist {
                bitmapInfo = CGImageAlphaInfo.none.rawValue
            }
            else {
                OpenCV.assign(&m, cv.Scalar(0))
            }
            
        }
        else if colorSpace.model == .indexed {
            colorSpace = CGColorSpaceCreateDeviceRGB()
            m.createMutating(Int32(rows), Int32(cols), OpenCV.u8c4);
            if !alphaExist {
                bitmapInfo = CGImageAlphaInfo.noneSkipLast.rawValue | CGImageByteOrderInfo.orderDefault.rawValue;
            }
            else {
                OpenCV.assign(&m, cv.Scalar(0))
            }
        }
        else {
            m.createMutating(Int32(rows), Int32(cols), OpenCV.u8c4);
            if !alphaExist {
                bitmapInfo = CGImageAlphaInfo.noneSkipLast.rawValue | CGImageByteOrderInfo.orderDefault.rawValue;
            }
            else {
                OpenCV.assign(&m, cv.Scalar(0))
            }
        }
        
        context = .init(data: m.data, width: cols, height: rows, bitsPerComponent: 8, bytesPerRow: m.step[0], space: colorSpace, bitmapInfo: bitmapInfo)

        guard let context else { return nil }
        
        context.draw(image, in: CGRect(x: 0, y: 0, width: cols, height: rows))
        
        let image = context.makeImage()
        
        return m;
    }
}

extension CGImage {
    
    public func toCvMat(alphaExist: Bool = false) -> cv.Mat? {
        var mat = cv.Mat()
        if let converted = cv.Mat.fromCGImage(self, m: &mat, alphaExist: alphaExist) {
            return converted
        }
        return nil
    }
    
    public func writeToCvMat(mat: inout cv.Mat, alphaExist: Bool) -> cv.Mat? {
        if let converted = cv.Mat.fromCGImage(self, m: &mat, alphaExist: alphaExist) {
            return converted
        }
        return nil
    }
}
