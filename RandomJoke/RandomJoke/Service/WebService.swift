//
//  WebService.swift
//  RandomJoke
//
//  Created by xindy.del.rosario on 11/26/22.
//

import Foundation

enum JokesError: Error {
    case invalidServerResponse
}

class WebService  {
    
    func getJokes(url: URL) async throws -> [JokesModel] {
        
       let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw JokesError.invalidServerResponse
        }
        
        return try JSONDecoder().decode([JokesModel].self, from: data)
    }
}
