//
//  RecipeView.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/2/24.
//

import SwiftUI

// Selections for the Picker
enum RecipeSections: String, CaseIterable {
    case ingredients = "Ingredients", instructions = "Instructions"
}

struct RecipeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: ViewModel
    let mealID: String
    
    @State private var recipes = [Recipe]()
    @State private var urlToLoad: URL?
    @State private var selectedRecipeSection: RecipeSections = .ingredients
    @State private var showingSafariView = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if let recipe = recipes.first {
                        RecipeImageView(recipe: recipe)
                        
                        RecipeBodyView(urlToLoad: $urlToLoad, showingSafariView: $showingSafariView, selectedRecipeSection: $selectedRecipeSection, recipe: recipe)
                        
                        Spacer()
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Disables the idle timer, so the device screen remains on while the recipe is shown
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .task {
                // Load selected recipe
                do {
                    let recipeData: RecipeData = try await vm.loadRemoteJSON(urlString: vm.baseURL + "lookup.php?i=\(mealID)")
                    recipes = recipeData.recipes
                } catch {
                    print("Error loading data: \(error.localizedDescription)")
                }
            }
            .sheet(isPresented: Binding(
                // SafariView attempts to load as a full screen view the first time it is triggered, without a getter/setter
                get: { showingSafariView },
                set: { showingSafariView = $0 }
            )) {
                if let urlToLoad {
                    SafariView(url: urlToLoad)
                        .ignoresSafeArea()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    dismissButton
                }
            }
        }
    }
    
    
    // MARK: - Views
    
    // Button to dismiss RecipeView
    private var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(.title2)
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color(.white), Color(.gray))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Close")
    }
}

#Preview {
    RecipeView(mealID: "52859")
        .environmentObject(ViewModel())
}
