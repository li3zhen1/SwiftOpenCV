//
//  CGImageView.swift
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

import Foundation
import SwiftUI

struct CGImageView<Placeholder>: View where Placeholder: View {
    var image: CGImage?
    
    let labelText: String
    
    let fit = true
    
    @ViewBuilder let placeholder: Placeholder
    
    @inlinable public init(image: CGImage?, labelText: String, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.placeholder = placeholder()
        self.image = image
        self.labelText = labelText
    }
    
    var body: some View {
        GeometryReader { g in
            if let image {
                
                Image(image, scale: 1.0, label: Text(labelText))
                    .resizable()
                    .scaledToFit()
                    .frame(width: g.size.width, height: g.size.height, alignment: .center)
                    .clipped()
                    
            }
            else {
                placeholder
            }
        }
    }
}
