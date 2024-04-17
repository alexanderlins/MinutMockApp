//
//  DataStructure.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-16.
//

import Foundation
import CoreData

struct Game: Codable, Identifiable {
    let id: Int
    let title: String
    let thumbnail: URL
    let shortDescription: String
    let gameUrl: URL
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let freetogameProfileUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail, genre, platform, publisher, developer
        case shortDescription = "short_description"
        case gameUrl = "game_url"
        case releaseDate = "release_date"
        case freetogameProfileUrl = "freetogame_profile_url"
    }
}


class GameDataHandler {
    
    static let shared =                         GameDataHandler()
    
    func saveGameToCoreData(game: Game, context: NSManagedObjectContext) {
        // Check for existing game
        let fetchRequest: NSFetchRequest<GamesList> = GamesList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", game.title)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                // Game does not exist, proceed to save
                let newGame = GamesList(context: context)
                newGame.id = Int64(game.id)
                newGame.title = game.title
                newGame.thumbnail = game.thumbnail
                newGame.shortDesc = game.shortDescription
                newGame.gameUrl = game.gameUrl
                newGame.genre = game.genre
                newGame.platform = game.platform
                newGame.publisher = game.publisher
                newGame.developer = game.developer
                newGame.releaseDate = game.releaseDate
                newGame.freetogameProfileUrl = game.freetogameProfileUrl
                try context.save()
                
            } else {
                // Game exists, skip or handle updates
                print("\(game.title) is already in the database.")
            }
        } catch {
            print("Failed to fetch for existing games: \(error)")
        }
    }
}
