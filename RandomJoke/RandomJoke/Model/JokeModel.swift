//
//  JokeModel.swift
//  RandomJoke
//
//  Created by xindy.del.rosario on 11/25/22.
//

import Foundation

struct JokesModel: Decodable {
    let type: String
    let setup: String
    let punchline: String
}

