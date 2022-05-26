//
//  Pokemon.swift
//  Pokedex
//
//  Created by Scott Cox on 5/26/22.
//

import Foundation

class Pokemon {
    enum Keys: String {
        case name = "name"
        case id = "id"
        case moves = "moves"
        case sprites = "sprites"
        case frontShiny = "front_shiny"
        case move = "move"
    }
    
    let name: String
    let id: Int
    let moves: [String]
    let spritePath: String
    
   
    init(name:String, id:Int, moves:[String], spritePosterPath: String){
        self.name = name
        self.id = id
        self.moves = moves
        self.spritePath = spritePosterPath
        
    }
}

extension Pokemon {
    convenience init?(dictionary:[String:Any]) {
        guard let name = dictionary[Keys.name.rawValue] as? String,
              let id = dictionary[Keys.id.rawValue] as? Int,
              let spriteDict = dictionary[Keys.sprites.rawValue] as? [String:Any],
              let spritePosterPath = spriteDict[Keys.frontShiny.rawValue] as? String,
              let movesArray = dictionary[Keys.moves.rawValue] as? [[String:Any]] else {return nil}
        
        var moves: [String] = []
        
        for dict in movesArray {
            guard let moveDict = dict[Keys.move.rawValue] as? [String:Any],
                  let moveName = moveDict[Keys.name.rawValue] as? String else {return nil}
            
            moves.append(moveName)
        }
        self.init(name: name, id: id, moves:moves, spritePosterPath: spritePosterPath)
    }
}
