//
//  QRRectangle.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 22/06/2023.
//

import SwiftUI

struct QRRectangle: View {
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .frame(width: UIScreen.main.bounds.size.width / QRRectangleParameters.frameWidthDivider,
                   height: UIScreen.main.bounds.size.height / QRRectangleParameters.frameHeightDivider)
            .overlay {
                HStack {
                    QRRectangleCorner()
                    
                    QRRectangleCorner()
                        .rotationEffect(.degrees(QRRectangleParameters.rotateElementDegrees))
                }
                
                HStack {
                    QRRectangleCorner()
                    
                    QRRectangleCorner()
                        .rotationEffect(.degrees(QRRectangleParameters.rotateElementDegrees))
                }
                .scaleEffect(CGSize(width: 1.0, height: -1.0))
            }
    }
}

struct QRRectangle_Previews: PreviewProvider {
    static var previews: some View {
        QRRectangle()
    }
}

enum QRRectangleParameters {
    static let frameWidthDivider: CGFloat = 1.2
    static let frameHeightDivider: CGFloat = 3
    static let rotateElementDegrees: CGFloat = 180
}
