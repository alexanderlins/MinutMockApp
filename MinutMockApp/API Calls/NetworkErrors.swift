//
//  NetworkErrors.swift
//  MinutMockApp
//
//  Created by Alexander Lins on 2024-04-16.
//

import Foundation

enum NetworkError: Error {
    case invalidEndpoint
    case requestFailed
    case jsonConversionFailure
    case jsonParsingFailure
    case responseUnsuccessful
    
    var localizedDescription: String {
            switch self {
            case            .invalidEndpoint:
                return      "Invalid Endpoint"
            
            case            .requestFailed:
                return      "Request Failed"
            
            case            .jsonConversionFailure:
                return      "JSON Conversion Failure"
            
            case            .jsonParsingFailure:
                return      "JSON Parsing Failure"
            
            case            .responseUnsuccessful:
                return      "Response Unsuccessful"
            }
        }
}
