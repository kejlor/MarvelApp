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
        Button {
            dismiss()
        } label: {
            Text("DismissButtonText".localized)
                .frame(maxWidth: .infinity)
                .bold()
        }
        .tint(.secondary)
        .buttonStyle(.borderedProminent)
        .padding(.horizontal)
        .controlSize(.large)
    }
}

struct DismissSheetButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissSheetButton()
    }
}
