//
//  CGImageView.swift
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

import Foundation
import SwiftUI

struct CGImageView: View {
    var image: CGImage?
    
    let labelText: String
    
    var body: some View {
        GeometryReader { g in
            if let image {
                Image(image, scale: 1.0, label: Text(labelText))
            }
            else {
                Text(labelText)
            }
        }
    }
}
