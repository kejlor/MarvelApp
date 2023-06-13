//
//  LocalizedString+Ext.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 13/06/2023.
//

import SwiftUI

struct LocalizedString {
    var key: String

    init(_ key: String) {
        self.key = key
    }

    func resolve() -> String {
        NSLocalizedString(key, comment: "")
    }
}

extension LocalizedString: ExpressibleByStringLiteral {
    init(stringLiteral value: StringLiteralType) {
        key = value
    }
}

extension LocalizedString {
    typealias Fonts = (default: UIFont, bold: UIFont)

    static func defaultFonts() -> Fonts {
        let font = UIFont.preferredFont(forTextStyle: .body)
        return (font, .boldSystemFont(ofSize: font.pointSize))
    }

    func attributedString(
        withFonts fonts: Fonts = defaultFonts()
    ) -> NSAttributedString {
        let components = resolve().components(separatedBy: "**")
        let sequence = components.enumerated()
        let attributedString = NSMutableAttributedString()

        return sequence.reduce(into: attributedString) { string, pair in
            let isBold = !pair.offset.isMultiple(of: 2)
            let font = isBold ? fonts.bold : fonts.default

            string.append(NSAttributedString(
                string: pair.element,
                attributes: [.font: font]
            ))
        }
    }
}

private extension LocalizedString {
    func render<T>(
        into initialResult: T,
        handler: (inout T, String, _ isBold: Bool) -> Void
    ) -> T {
        let components = resolve().components(separatedBy: "**")
        let sequence = components.enumerated()

        return sequence.reduce(into: initialResult) { result, pair in
            let isBold = !pair.offset.isMultiple(of: 2)
            handler(&result, pair.element, isBold)
        }
    }
}

extension LocalizedString {
    func styledText() -> Text {
        render(into: Text("")) { fullText, string, isBold in
            var text = Text(string)

            if isBold {
                text = text.bold()
            }

            fullText = fullText + text
        }
    }
}

extension Text {
    init(styledLocalizedString string: LocalizedString) {
        self = string.styledText()
    }
}
