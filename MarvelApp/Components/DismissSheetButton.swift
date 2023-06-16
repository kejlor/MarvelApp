//
//  DismissSheetButton.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 16/06/2023.
//

import SwiftUI

struct DismissSheetButton: View {
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        Button("Dismiss Me") {
            dismiss()
        }
    }
}

struct DismissSheetButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissSheetButton()
    }
}
