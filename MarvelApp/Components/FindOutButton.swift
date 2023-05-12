//
//  FindOutButton.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

struct FindOutButton: View {
    var stringUrl: String
    
    var body: some View {
        Button {
            if let url = URL(string: stringUrl) {
                UIApplication.shared.open(url)
            }
        } label: {
            Text("Find out more")
                .frame(maxWidth: .infinity)
                .bold()
        }
        .tint(.red)
        .buttonStyle(.borderedProminent)
        .padding()
        .controlSize(.large)
    }
}

struct FindOutButton_Previews: PreviewProvider {
    static var previews: some View {
        FindOutButton(stringUrl: "https://www.marvel.com/comics/issue/183/startling_stories_the_incorrigible_hulk_2004_1?utm_campaign=apiRef&utm_source=080a502746c8a60aeab043387a56eef0")
    }
}
