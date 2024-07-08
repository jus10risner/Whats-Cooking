//
//  ViewModel.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/6/24.
//

import Foundation

class ViewModel: ObservableObject {
    let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    // Loads JSON data from the given URL
    func loadRemoteJSON<T: Codable>(urlString: String, completion: @escaping  ((T) -> Void)) async {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                completion(decodedResponse)
            }
        } catch {
            print("Invalid data")
        }
    }
}
