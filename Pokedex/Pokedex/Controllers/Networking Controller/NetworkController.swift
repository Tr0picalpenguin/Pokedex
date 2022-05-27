//
//  NetworkController.swift
//  Pokedex
//
//  Created by Scott Cox on 5/26/22.
//

import Foundation

class NetworkController {
    
    private static let baseURLString = "https://pokeapi.co"
    
    static func fetchPokemon(searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else {return}
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        urlComponents?.path = "/api/v2/pokemon/\(searchTerm.lowercased())"
        
        guard let finalURL = urlComponents?.url else {return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { taskData, _, error in
            if let error = error {
                print("You can't catch them all when you Encounter an Error like this. The url is \(finalURL), the error is \(error.localizedDescription)")
                      completion(nil)
                      }
                      
            guard let pokemonData = taskData else {return}
            
                do {
                    if let topLevelDictionary = try JSONSerialization.jsonObject(with: pokemonData, options: .allowFragments) as? [String:Any] {
                        let pokemon = Pokemon(dictionary: topLevelDictionary)
                        completion(pokemon)
                    }
                } catch {
                    print("Encountered error when decoding the data", error.localizedDescription)
                    completion(nil)
                }
            }.resume()
        }
                
    } // End of class
