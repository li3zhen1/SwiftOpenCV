//
//  OpenCVCanvasView.swift
//  SwiftOpenCV
//
//  Created by 李臻 on 2/28/23.
//

import SwiftUI
import OpenCVWrapper

func duration(out:Int,h2:Int,rep:Int,cani:inout Bool){
    var io = 0
    var b  = 0
    var text: String

}



struct OpenCVCanvasView: View {
    @State var elapsed = 0
    @State var test = 0
    
    @State var model = OpenCVMediaViewModel()
    
    var body: some View {
        VStack {
            Canvas { context, cgSize in
                if let img = model.current {
                    context.draw(Image(img, scale: 1.0, label: Text("")), in: CGRect(x: 0, y: 0, width: cgSize.width, height: cgSize.height))
                }
                
                
            }.border(.red)
            
            Button {
                elapsed += 1
            } label: {
                Text(
                    "ASAS"
                )
            }
            
            Button {
                test += 1
            } label: {
                Text(
                    "ASAS2"
                )
            }

        }
        
        
    }
}



struct OpenCVCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        OpenCVCanvasView()
    }
}
