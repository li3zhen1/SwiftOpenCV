//
//  ContentView.swift
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

import SwiftUI
import OpenCVWrapper

struct Homework: Identifiable {
    typealias ID = Int
    let id: ID
    let name: String
    let tasks: [Subtask]
}

struct Subtask: Identifiable {
    typealias ID = Int
    let id: ID
    let name: String
}

let homework: [Homework] = [
    .init(id: 0, name: "Hello World", tasks: [
        .init(id: 0, name: "Capture Video"),
        .init(id: 1, name: "Open Media"),
        .init(id: 2, name: "Add Text to Media")
    ]),
    //    .init(id: 1, name: "Light", tasks: [
    //        .init(id: 0, name: "Light 1"),
    //    ])
]

struct Homework1CaptureVideoView: View {
    @StateObject var model = OpenCvCameraViewModel()
    var body: some View {
        VStack {
            CGImageView(image: model.current, labelText: "OpenCV Camera") {
                ProgressView("Connecting Camera")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear {
                Task {
                    await model.startCapture()
                }
            }
            .onDisappear {
                model.stopCapture()
            }
        }
    }
}

struct Homework1OpenMediaView: View {
    @StateObject var model = OpenCVMediaViewModel()
    let text: String?
    init (_ text: String? = nil ) {
        self.text = text
    }
    
    var body: some View {
        VStack {
            Button {
                Task {
                    if let url = await pickFile() {
                        _ = model.loadMedia(url, text)
                    }
                }
            } label: {
                Text("Open Media (ASCII path name required)")
            }
            .padding(.all)
            .zIndex(999)
            
            Canvas { context, cgSize in
                if let img = model.current {
                    let scale = min(Double(cgSize.width)/Double(img.width), Double(cgSize.height)/Double(img.height))
                    
                    context.scaleBy(x: scale, y: scale)
                    context.draw(Image(img, scale: 1.0, label: Text("")), in: CGRect(x: 0, y: 0, width: img.width, height: img.height))
                    if let text {
                        context.draw(Text(text).font(.largeTitle).foregroundColor(.white).bold(), in: CGRect(x: 20, y: 20, width: 1000, height: cgSize.height))
                    }
                }
            }

        }
    }
    
    func pickFile() async -> URL? {
        let folderPicker = NSOpenPanel()
        folderPicker.canChooseDirectories = false
        folderPicker.canChooseFiles = true
        folderPicker.allowsMultipleSelection = false
        folderPicker.canDownloadUbiquitousContents = false
        folderPicker.canResolveUbiquitousConflicts = false
        
        folderPicker.allowedContentTypes = [.movie, .mpeg4Movie, .png, .jpeg, .webP]
        
        if let window = NSApplication.shared.mainWindow {
            let response = await folderPicker.beginSheetModal(for: window)
            if response == .OK {
                return folderPicker.url
            }
        }
        
        return nil
    }
}

struct ContentView: View {
    @State private var visibility = NavigationSplitViewVisibility.all
    @State private var selectedHomework = 0
    @State private var selectedSubtask = 1
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(homework, selection: $selectedHomework) { hw in
                Text(hw.name)
            }
        } content: {
            List(homework[0].tasks, selection: $selectedSubtask) { st in
                Text(st.name)
            }
        } detail: {
            switch(selectedHomework, selectedSubtask) {
            case (0, 0):
                Homework1CaptureVideoView()
            case (0, 1):
                Homework1OpenMediaView()
            case (0, 2):
                Homework1OpenMediaView("2201210621 李臻")
            default:
                EmptyView()
            }
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
