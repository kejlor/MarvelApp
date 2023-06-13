//
//  LocalizedString+Ext.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 13/06/2023.
//

import Foundation

extension String {

var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
}

func localized(_ args: [CVarArg]) -> String {
    return String(format: localized, args)
}

func localized(_ args: CVarArg...) -> String {
    return String(format: localized, args)
}
}
