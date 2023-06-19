//
//  ComicSheetView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 12/05/2023.
//

import SwiftUI

struct ComicSheetView: View {
    var comicVM: ComicViewModel
    @State var isAnimating = false
    var viewWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment:. leading) {
                
                Text(comicVM.title)
                    .font(.title3)
                    .bold()
                    .padding(.vertical, ComicSheetViewParameters.titlePadding)
                    .animation(.easeOut(duration: ComicSheetViewParameters.titleAnimationDuration), value: isAnimating)
                
                Text(comicVM.creators)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .animation(.easeOut(duration: ComicSheetViewParameters.creatorsAnimationDuration), value: isAnimating)
                
                ScrollView {
                    Text(comicVM.description)
                        .padding(.vertical, ComicSheetViewParameters.descriptionPadding)
                        .font(.callout)
                        .lineLimit(nil)
                        .frame(maxWidth: .infinity)
                }
                
                Spacer()
                    .frame(height: ComicSheetViewParameters.spacerHeight)
            }
            .offset(x: isAnimating ? ComicSheetViewParameters.comicSheetViewOffsetAnimation : viewWidth)
            .opacity(isAnimating ? ComicSheetViewParameters.comicSheetOpacityVisible : ComicSheetViewParameters.comicSheetOpacityInvisible)
            
            FindOutButton(stringUrl: comicVM.moreData)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct ComicSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ComicSheetView(comicVM: ComicViewModel(comic: Comic(id: 1, title: "Avengers #39", description: "Re-live the legendary first journey into the dystopian future of 2013 - where Sentinels stalk the Earth, and the X-Men are humanity's only hope...until they die! Also featuring the first appearance of Alpha Flight, the return of the Wendigo, the history of the X-Men from Cyclops himself...and a demon for Christmas!? ", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/d0/58b5cfb6d5239"), creators: CreatorResponse(items: [Creator(name: "JJ Abrams"), Creator(name: "Allan"), Creator(name: "John Doe")]), urls: [UrlResponse(type: "detail", url: "https://www.marvel.com/comics/issue/183/startling_stories_the_incorrigible_hulk_2004_1?utm_campaign=apiRef&utm_source=080a502746c8a60aeab043387a56eef0")])))
    }
}

enum ComicSheetViewParameters {
    static let titlePadding: CGFloat = 2
    static let descriptionPadding: CGFloat = 5
    static let spacerHeight: CGFloat = 150
    static let comicSheetViewOffsetAnimation: CGFloat = 0
    static let comicSheetOpacityVisible: CGFloat = 1
    static let comicSheetOpacityInvisible: CGFloat = 0
    static let titleAnimationDuration: Double = 1.5
    static let creatorsAnimationDuration: Double = 1.8
}
