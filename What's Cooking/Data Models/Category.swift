//
//  Category.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/2/24.
//

import SwiftUI

// MARK: Category Model

struct Category: Codable {
    let id: String
    let title: String
    let thumbnailURL: String
    let description: String
    
    
    // Used to simplify property names
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case title = "strCategory"
        case thumbnailURL = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
    
    // Example Category, for use in Previews
    static let example = Category(id: "3", title: "Dessert", thumbnailURL: "https://www.themealdb.com/images/category/dessert.png", description: "")
}


// MARK: - CategoryData Model

struct CategoryData: Codable {
    let categories: [Category]
}
