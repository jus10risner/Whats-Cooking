//
//  Recipe.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/2/24.
//

import Foundation

// MARK: Recipe Model

struct Recipe: Codable {
    let id: String
    let title: String
    let category: String
    let origin: String?
    let instructions: String
    let thumbnailURL: String
    let youTubeURL: String?
    let recipeSource: String?
    let ingredients: [Ingredient]
    
    var formattedInstructions: String {
        return self.instructions.replacingOccurrences(of: "[\r\n]+", with: "\n\n", options: .regularExpression)
    }
    
    // Used to simplify property names
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case category = "strCategory"
        case origin = "strArea"
        case instructions = "strInstructions"
        case thumbnailURL = "strMealThumb"
        case youTubeURL = "strYoutube"
        case recipeSource = "strSource"
    }
    
    // Example Recipe, for use in Previews
    static let example = Recipe(id: "52883", title: "Sticky Toffee Pudding", category: "Dessert", origin: "British", instructions: "Preheat the oven to 180C/160C Fan/Gas 4. Butter a wide shallow 1.7-litre/3-pint ovenproof dish.\n\nPut the butter, sugar, eggs, flour, baking powder, bicarbonate of soda and treacle into a mixing bowl. Beat using an electric handheld whisk for about 30 seconds or until combined. Pour in the milk gradually and whisk again until smooth. Pour into the prepared dish. Bake for 35 minutes or until well risen and springy in the centre.\r\nTo make the sauce, put all the ingredients into a saucepan and stir over a low heat until the sugar has dissolved and the butter has melted. Bring to the boil, stirring for a minute.\r\nTo serve, pour half the sauce over the pudding in the baking dish. Serve with the cream or ice cream.", thumbnailURL: "https://www.themealdb.com/images/media/meals/xqqqtu1511637379.jpg", youTubeURL: "https://www.youtube.com/watch?v=Wytv3bjqJII", recipeSource: "https://www.bbc.co.uk/food/recipes/marys_sticky_toffee_41970", ingredients: Recipe.exampleIngredients)
}


// MARK: - Ingredient Model

struct Ingredient: Codable, Hashable {
    let name: String
    let measure: String
}


// MARK: - RecipeData Model

struct RecipeData: Codable {
    let recipes: [Recipe]
    
    // Used to simplify property names
    enum CodingKeys: String, CodingKey {
        case recipes = "meals"
    }
}


// MARK: - Extensions

extension Recipe {
    // This serves primarily to tame an unwiedly api. It takes up to 20 ingredient and measurement fields, and it creates Ingredient objects with the content from non-empty fields, appending those objects to an array.
    init(from decoder: Decoder) throws {
       let container = try decoder.singleValueContainer()
       let recipeDictionary = try container.decode([String: String?].self)
       var index = 1
       var ingredients: [Ingredient] = []
        
       while let ingredient = recipeDictionary["strIngredient\(index)"] as? String, let measure = recipeDictionary["strMeasure\(index)"] as? String, !ingredient.isEmpty {
           ingredients.append(.init(name: ingredient, measure: measure))
           index += 1
       }
        
        self.ingredients = ingredients
        
        id = recipeDictionary["idMeal"] as? String ?? ""
        title = recipeDictionary["strMeal"] as? String ?? ""
        category = recipeDictionary["strCategory"] as? String ?? ""
        origin = recipeDictionary["strArea"] as? String ?? ""
        instructions = recipeDictionary["strInstructions"] as? String ?? ""
        thumbnailURL = recipeDictionary["strMealThumb"] as? String ?? ""
        youTubeURL = recipeDictionary["strYoutube"] as? String ?? ""
        recipeSource = recipeDictionary["strSource"] as? String ?? ""
    }
    
    
    // Provides an array of ingredients for the Recipe example
    static let exampleIngredients: [Ingredient] = [
        Ingredient(name: "Butter", measure: "100g"),
        Ingredient(name: "Muscovado Sugar", measure: "175g"),
        Ingredient(name: "Eggs", measure: "2 large"),
        Ingredient(name: "Self-raising flour", measure: "225g"),
        Ingredient(name: "Baking Powder", measure: "1 tsp"),
        Ingredient(name: "Bicarbonate of Soda", measure: "1 tsp"),
        Ingredient(name: "Black Treacle", measure: "3 tbs"),
        Ingredient(name: "Milk", measure: "275ml"),
        Ingredient(name: "Double Cream", measure: "to serve"),
        Ingredient(name: "Butter", measure: "100g"),
        Ingredient(name: "Muscovado Sugar", measure: "125g"),
        Ingredient(name: "Black Treacle", measure: "1 tbs"),
        Ingredient(name: "Double Cream", measure: "300ml"),
        Ingredient(name: "Vanilla Extract", measure: "1 tsp")
    ]
}
