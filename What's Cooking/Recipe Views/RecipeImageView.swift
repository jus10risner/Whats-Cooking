//
//  RecipeImageView.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/6/24.
//

import SwiftUI

struct RecipeImageView: View {
    let recipe: Recipe
    
    var body: some View {
        AsyncImage(url: URL(string: recipe.thumbnailURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .scaledToFill()
        .ignoresSafeArea()
        .frame(height: 300)
        .clipShape(Rectangle())
    }
}

#Preview {
    RecipeImageView(recipe: Recipe.example)
}
