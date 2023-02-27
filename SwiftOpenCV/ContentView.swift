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
    var body: some View {
        VStack {
            CGImageView(image: readImage(path: "/Users/lizhen/Movies/Screenshot 2023-02-23 at 16.54.33.png"), labelText: "Test")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
