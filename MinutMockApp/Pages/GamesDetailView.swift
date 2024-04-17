//
//  GamesDetailView.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-17.
//

import SwiftUI

struct GamesDetailView: View {
    @State var game: Game
    
    var body: some View {
        VStack {
            AsyncImage(url: game.thumbnail) { image in
                image
                    .gameThumbnail()
                    .frame(width:UIScreen.main.bounds.width, height: 350)
                    
            } placeholder: {
                ProgressView().frame(width: 50, height:50)
            }
            
            Text("\(game.title)").personalSubtitle()
            HStack {
                Text("\(game.developer)").personalCaption()
                Spacer()
                Text("\(game.releaseDate)").personalCaption()
            }.padding(.horizontal)
            
            Text("\(game.shortDescription)").personalBody().padding(.horizontal, 8).padding(.top)

        }.frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        .personalBackground()
    }
}
