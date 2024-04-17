//
//  GamesView.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-16.
//

import SwiftUI

struct GamesView: View {
    
    @Binding var games: [Game]
    @Binding var path: [String]
    @Binding var searchTerm: String
    var filteredTitles: [Game] {
        guard !searchTerm.isEmpty else {return games}
        return games.filter {$0.title.localizedCaseInsensitiveContains(searchTerm)}
    }
    
    var body: some View {
        
            ScrollView (.vertical, showsIndicators: false) {
                
                VStack {
                    ForEach(filteredTitles) { game in
                        GameCardView (
                            game: game, path: $path)
                    }.searchable(text: $searchTerm, placement: .automatic, prompt: "Search for title")
                }
                
            }
            .padding(.vertical, 96)
            .padding(.horizontal, 32)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {path.removeLast()} label: {
                        Image(systemName: "arrowtriangle.backward.square.fill").foregroundStyle(.orange)
                    }
                    
                }
            }
        
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .personalBackground()
    }
}
