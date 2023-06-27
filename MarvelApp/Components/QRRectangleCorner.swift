//
//  QRRectangleCorner.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 22/06/2023.
//

import SwiftUI

struct QRRectangleCorner: View {
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: QRRectangleCornerParameters.topRectangleLength, y: .zero))
                path.addLine(to: CGPoint(x: QRRectangleCornerParameters.topRectangleLength, y: QRRectangleCornerParameters.topRectangleWidth))
                path.addLine(to: CGPoint(x: .zero, y: QRRectangleCornerParameters.topRectangleWidth))
                path.addLine(to: .zero)
                path.closeSubpath()
            }
            .fill(QRRectangleCornerParameters.fillColor)
            
            Path { path in
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: .zero, y: QRRectangleCornerParameters.bottomRectangleWidth))
                path.addLine(to: CGPoint(x: QRRectangleCornerParameters.bottomRectangleLength, y: QRRectangleCornerParameters.bottomRectangleWidth))
                path.addLine(to: CGPoint(x: QRRectangleCornerParameters.bottomRectangleLength, y: .zero))
                path.addLine(to: .zero)
                path.closeSubpath()
            }
            .fill(QRRectangleCornerParameters.fillColor)
        }
    }
}

struct QRRectangleCorner_Previews: PreviewProvider {
    static var previews: some View {
        QRRectangleCorner()
    }
}

enum QRRectangleCornerParameters {
    static let topRectangleWidth: CGFloat = 10
    static let topRectangleLength: CGFloat = 100
    static let bottomRectangleWidth: CGFloat = 100
    static let bottomRectangleLength: CGFloat = 10
    static let fillColor: Color = .white
}
