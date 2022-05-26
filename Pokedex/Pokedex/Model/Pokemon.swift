//
//  Pokemon.swift
//  Pokedex
//
//  Created by Scott Cox on 5/26/22.
//

import Foundation

class Pokemon {
    
    enum Keys: String {
        case kName = "name"
        case kId = "id"
        case kMoves = "moves"
        case kSprites = "sprites"
        case kFrontShiny = "front_shiny"
        case kMove = "move"
    }
    
    let name: String
    let id: Int
    let moves: [String]
    let spritePath: String
    
    init(name: String, id: Int, moves: [String], spritePath: String) {
        self.name = name
        self.id = id
        self.moves = moves
        self.spritePath = spritePath
    }
} // End of class
    
    extension Pokemon {
        convenience init?(dictionary: [String:Any]) {
        guard let name = dictionary[Keys.kName.rawValue] as? String,
            let id = dictionary[Keys.kId.rawValue] as? Int,
            let spriteDict = dictionary[Keys.kSprites.rawValue] as? [String:Any],
              let spritePosterPath = dictionary[Keys.kFrontShiny.rawValue] as? String,
            let movesArray = dictionary[Keys.kMoves.rawValue] as? [[String:Any]]
            else {return nil}
            
            var moves: [String] = []
            
            for dict in movesArray {
                guard let moveDict = dict[Keys.kMove.rawValue] as? [String:Any],
                      let moveName = dict[Keys.kName.rawValue] as? String else {return nil}
                        
            moves.append(moveName)
                
            self.init(name: name, id: id, moves: movesArray, spritePath: spritePosterPath)
            }
        }
}
