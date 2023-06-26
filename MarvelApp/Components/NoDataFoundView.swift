//
//  NoDataFoundView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 26/06/2023.
//

import SwiftUI

struct NoDataFoundView: View {
    var icon: String
    var text: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(.secondary)
                .font(.system(size: NoDataFoundViewParameters.iconHeight))
            
            Text(text)
                .bold()
                .padding(.vertical)
        }
    }
}

struct NoDataFoundView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataFoundView(icon: "star.fill", text: "Any message")
    }
}

enum NoDataFoundViewParameters {
    static let iconHeight: CGFloat = 70
}
