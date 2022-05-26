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

         URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
             if let error = error {
                 print("You can't catch them all whe you Encounter an Error like this.", error.localizedDescription)
                 completion(nil)
             }
         }
     }
} // End of class
