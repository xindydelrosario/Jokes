//
//  JokeListViewModel.swift
//  RandomJoke
//
//  Created by xindy.del.rosario on 11/25/22.
//

import Foundation


class JokeListViewModel {
    
    private(set) var jokes: [JokeViewModel] = []
    
    func populateJokes(url: URL) async {
        
        do {
            let jokes = try await WebService().getJokes(url: url)
            self.jokes = jokes.map(JokeViewModel.init)
        } catch {
            print(error)
        }
    }
}


struct JokeViewModel {
    private let joke: JokesModel
    
    init(joke: JokesModel) {
        self.joke = joke
    }
    
    
    var type: String {
         joke.type
    }
    
    var setup: String {
         joke.setup
    }
    
    var punchline: String {
        joke.punchline
    }
}
