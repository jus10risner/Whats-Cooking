//
//  ViewModel.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/6/24.
//

import Foundation

@MainActor
final class ViewModel: ObservableObject {
    let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    // Loads JSON data from the given URL
    func loadRemoteJSON<T: Codable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
