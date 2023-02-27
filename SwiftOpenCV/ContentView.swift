//
//  ContentView.swift
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

import SwiftUI
import OpenCVWrapper

func readImage(path: String) -> CGImage? {
    return OpenCV.readImage(path).toCGImage()
}


struct ContentView: View {
    @StateObject var model = OpenCvCameraViewModel()
    var body: some View {
        VStack {
            CGImageView(image: model.current, labelText: "Test")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Button {
                model.startCapture()
            } label: {
                Text("Capture")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
