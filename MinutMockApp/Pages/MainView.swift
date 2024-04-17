//
//  MainView.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-16.
//

import SwiftUI
import CoreData

struct MainView: View {
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var path: [String] = []
    @State private var games: [Game] = []
    @State var searchTerm: String = ""
    
    @State var game: Game = Game(
        id: 0,
        title: "",
        thumbnail: URL(fileURLWithPath: ""),
        shortDescription: "",
        gameUrl: URL(fileURLWithPath: ""),
        genre: "",
        platform: "",
        publisher: "",
        developer: "",
        releaseDate: "",
        freetogameProfileUrl: URL(fileURLWithPath: ""))
    
    @State private var isActive: Bool = false
    
    @FetchRequest(
            entity: GamesList.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \GamesList.title, ascending: true)]
        ) var gamesDataLoaded: FetchedResults<GamesList>
    
    
    var body: some View {
        
        NavigationStack(path: $path) {
            ZStack {
                Controller()
                    .opacity(isActive ? 1 : 0.4)
                
                
                VStack {
                    
                    VStack {
                        HStack {
                            Text("Showcasing\niOS\nDevelopment")
                                .personalTitle()
                                .padding(.top, 64)
                                .padding(.leading, 8)
                            Spacer()
                        }
                        
                        Spacer()
                        
                        
                        HStack {
                            Text("Thanks for taking your time\nHere you can get a glimpse\non how I build apps")
                                .personalBody()
                                .padding(.leading, 8)
                            Spacer()
                        }
                        
                        
                    }.frame(width: UIScreen.main.bounds.width, height: 375)
                    
                    Spacer()
                    
                    Button {path.append("API")} label: {
                        ZStack {
                            Hexagon()
                                .hexagonColor()
                            Text("Go")
                                .nextPage()
                        }
                    }.padding(.bottom, 64)
                }.opacity(isActive ? 0 : 1)
                
                .navigationDestination(for: String.self) { value in
                    switch value {
                    case "API":
                        GamesView(games: $games, path: $path, searchTerm: $searchTerm).environment(\.managedObjectContext, persistenceController.container.viewContext)
                        
                    default:
                        Text("Error")
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isActive.toggle()
                    } label: {
                        Image(systemName: isActive ? "eye.fill" : "eye.slash.fill").foregroundStyle(.orange)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .personalBackground()
            
        }
        .onAppear {
            fetchingList()
            print(gamesDataLoaded.first?.title)
        }
    }
    
    private func fetchingList() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APICaller().fetching(endpoint: Endpoints()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let games):
                    for game in games {
                        GameDataHandler.shared.saveGameToCoreData(game: game, context: self.managedObjectContext)
                        updateGamesList()
                    }
                    
                    
                    
                case .failure(_):
                    let error = NetworkError.requestFailed
                    print(error)
                }
                dispatchGroup.leave()
            }
        }
    }
    
    private func updateGamesList() {
            let existingTitles = Set(games.map { $0.title })  // Create a set of existing titles for quick lookup

            for game in gamesDataLoaded {
                print("Loaded from the Database: \(game.title ?? "Unknown Title")")
                if !existingTitles.contains(game.title ?? "") {
                    // Only append if the title isn't already in the existing titles set
                    if let id = Int(exactly: game.id),
                       let title = game.title,
                       let thumbnail = game.thumbnail,
                       let shortDesc = game.shortDesc,
                       let gameUrl = game.gameUrl,
                       let genre = game.genre,
                       let platform = game.platform,
                       let publisher = game.publisher,
                       let developer = game.developer,
                       let releaseDate = game.releaseDate,
                       let freetogameProfileUrl = game.freetogameProfileUrl {
                        
                        let newGame = Game(
                            id: id,
                            title: title,
                            thumbnail: thumbnail,
                            shortDescription: shortDesc,
                            gameUrl: gameUrl,
                            genre: genre,
                            platform: platform,
                            publisher: publisher,
                            developer: developer,
                            releaseDate: releaseDate,
                            freetogameProfileUrl: freetogameProfileUrl
                        )
                        
                        self.games.append(newGame)
                        print("Added new game to list: \(title)")
                    }
                } else {
                    print("Game already in Database: \(game.title ?? "Unknown Title")")
                }
            }
        }
}

/*#Preview {
    MainView()
}*/
