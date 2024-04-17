//
//  GameCardView.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-16.
//

import SwiftUI

struct GameCardView: View {
    
    @State var game: Game
    @Binding var path: [String]
    @State private var isActive: Bool = false
    
    var body: some View {
        VStack {
            
            Button {isActive.toggle()} label: {
                
                VStack {
                    
                    HStack {
                        VStack {
                            Text("\(game.title)").personalSubtitle()
                        }
                        
                        Spacer()
                        
                        Text("\(game.genre)").personalCaption()
                        
                        switch game.platform {
                        case "Web Browser":
                            Image(systemName: "network").gamePlatform()
                        case "PC (Windows)":
                            Image(systemName: "desktopcomputer").gamePlatform()
                        case "PC (Windows), Web Browser":
                            HStack {
                                Image(systemName: "network").gamePlatform()
                                Image(systemName: "desktopcomputer").gamePlatform()
                            }
                        default:
                            Text("\(game.platform)").personalTag()
                        }
                        
                    }
                    
                    HStack {
                        Text("\(game.shortDescription)").personalBody()
                        Spacer()
                    }
                }.sheet(isPresented: $isActive, content: {
                    GamesDetailView(game: game)
                })
                
            }
            

        }.padding(.vertical)
    }
}
