//
//  APICalls.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-16.
//

import Foundation

class APICaller {
    
    // Singleton
    static let shared =                         APICaller()
    
    // Session Configuration
    let customSession: URLSession = {
        let customConfig =                      URLSessionConfiguration.default
        let backgroundConfig =                  URLSessionConfiguration.background(withIdentifier: "")
        customConfig.networkServiceType =       .default
        customConfig.allowsCellularAccess =     true
        
        return URLSession(configuration: customConfig)
    }()
    
    // MARK: GET from an Endpoint
    func fetching(endpoint: Endpoints, completion: @escaping (Result<[Game], Error>) -> Void) {
        
        //DIVIDE THE URL IN DIFERENT PARTICLES
        let componentURL = URLComponents(string: endpoint.getAllGames)
        
        //ANALIZE IF THE URL IS VALID
        guard let validURL =    componentURL?.url else {
            print("URL Failed")
            return
        }
        
        var getRequest = URLRequest(url: validURL)
        getRequest.httpMethod = "GET"
        
        
        //START URL SESSION
        URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("API status for retrieving work: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let works = try JSONDecoder().decode([Game].self, from: validData)
                completion(.success(works))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
    }
}
