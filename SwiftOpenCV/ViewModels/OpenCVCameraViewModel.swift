//
//  OpenCVCameraManager.swift
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

import Foundation
import CoreImage
import OpenCVWrapper
import AVFoundation


class OpenCvCameraViewModel: CGImageViewModel {
    
    @Published var capturing: Bool = false
    var videoCapture: cv.VideoCapture?
    var captured: cv.Mat
    var timer: Timer?
    
    var authorizationStatus: AVAuthorizationStatus = .notDetermined
    
    override init() {
        captured = cv.Mat()
    }
    
    
    func checkPermission() async -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if (status == .notDetermined) {
            let authorized = await AVCaptureDevice.requestAccess(for: .video)
            if !authorized {
                self.authorizationStatus = .denied
            }
            else {
                self.authorizationStatus = .authorized
            }
            return authorized
        }
        else {
            authorizationStatus = status
            return status == .authorized
        }
    }
    
    func startCapture(_ deviceId: Int32 = 1) async {
        if capturing { return }
        
        guard await checkPermission() else { return }
        
        videoCapture = cv.VideoCapture(deviceId, 0)
        
        guard videoCapture!.isOpened() else {
            videoCapture!.releaseMutating()
            return
        }
        
        await MainActor.run {
            timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { t in
                if var vc = self.videoCapture {
                    OpenCV.captureFrame(&vc, &self.captured)
                    self.current = self.captured.toCGImage()
                }
            }
            timer!.fire()
            capturing = true
        }
    }
    
    func stopCapture() {
        timer?.invalidate()
        timer = nil
        capturing = false
        videoCapture?.releaseMutating()
        videoCapture = nil
    }
    
    deinit {
        stopCapture()
        print("DEINIT")
    }
    
}
