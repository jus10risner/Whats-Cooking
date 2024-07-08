//
//  MealPreview.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/2/24.
//

import Foundation

// MARK: MealPreview Model

struct MealPreview: Codable, Identifiable {
    let id: String
    let title: String
    let thumbnailURL: String
    
    // Used to simplify property names
    enum CodingKeys: String, CodingKey {
        case title = "strMeal"
        case thumbnailURL = "strMealThumb"
        case id = "idMeal"
    }
    
    // Example MealPreview, for use in view Previews
    static let example = MealPreview(id: "52883", title: "Sticky Toffee Pudding", thumbnailURL: "https://www.themealdb.com/images/media/meals/xqqqtu1511637379.jpg")
}


// MARK: - MealPreviewData Model

struct MealPreviewData: Codable {
    let mealPreviews: [MealPreview]
    
    // Used to simplify property names
    enum CodingKeys: String, CodingKey {
        case mealPreviews = "meals"
    }
}
