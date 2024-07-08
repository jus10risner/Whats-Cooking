//
//  RecipeBodyView.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/6/24.
//

import SwiftUI

struct RecipeBodyView: View {
    @Binding var urlToLoad: URL?
    @Binding var showingSafariView: Bool
    @Binding var selectedRecipeSection: RecipeSections
    let recipe: Recipe
    let sectionSpacing: CGFloat = 30
    let elementSpacing: CGFloat = 5
    let ingredientSpacing: CGFloat = 10
    
    var body: some View {
        VStack(alignment: .leading, spacing: sectionSpacing) {
            VStack(spacing: elementSpacing) {
                Text(recipe.title.capitalized)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                if let origin = recipe.origin {
                    Text("Cuisine: \(origin)")
                        .foregroundStyle(Color.secondary)
                }
                
                HStack {
                    // If a recipe source url exists, and it is a valid url, load it in SafariView
                    if let recipeSource = recipe.recipeSource, let url = URL(string: recipeSource) {
                        if recipeSource != "" {
                            Button {
                                urlToLoad = url
                                showingSafariView = true
                            } label: {
                                Text(url.host()?.replacingOccurrences(of: "www.", with: "") ?? recipeSource)
                            }
                        }
                    }
                    
                    if recipe.recipeSource?.isEmpty == false && recipe.youTubeURL?.isEmpty == false {
                        Divider()
                    }
                    
                    // If a YouTube url exists, and it is a valid url, load it in SafariView
                    if let youTubeURL = recipe.youTubeURL, let url = URL(string: youTubeURL) {
                        if youTubeURL != "" {
                            Button {
                                urlToLoad = url
                                showingSafariView = true
                            } label: {
                                Text("YouTube")
                            }
                        }
                    }
                }
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity)
            
            
            Picker("Section", selection: $selectedRecipeSection) {
                ForEach(RecipeSections.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            if selectedRecipeSection == .ingredients {
                VStack(alignment: .leading, spacing: ingredientSpacing) {
                    ForEach(recipe.ingredients, id: \.self) { item in
                        HStack(spacing: 3) {
                            Text(item.measure)
                                .font(.subheadline.bold())
                            
                            Text(item.name)
                                .font(.subheadline)
                        }
                    }
                }
            } else {
                Text(recipe.formattedInstructions)
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

#Preview {
    RecipeBodyView(urlToLoad: .constant(URL(string: Recipe.example.recipeSource!)), showingSafariView: .constant(false), selectedRecipeSection: .constant(.ingredients), recipe: Recipe.example)
}
