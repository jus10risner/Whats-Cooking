//
//  MealListView.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/2/24.
//

import SwiftUI

struct MealListView: View {
    @EnvironmentObject var vm: ViewModel
    let category: String
    let columns = [ GridItem(.adaptive(minimum: 150), spacing: 5) ]
    
    @State private var mealPreviews = [MealPreview]()
    @State private var selectedMeal: MealPreview?
    @State private var showingRecipe = false
    @State private var searchText = ""
    
    // Array of mealPreviews, filtered by search term, if applicable
    private var searchResults: [MealPreview] {
        // Sort mealPreviews alphabetically, by title
        let sortedMeals = mealPreviews.sorted(by: { $0.title < $1.title })
        
        if searchText.isEmpty {
            // Return all sortedMeals, if searchText is empty
            return sortedMeals
        } else {
            // Return sortedMeals with names matching searchText
            return sortedMeals.filter({ $0.title.contains(searchText) })
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(searchResults, id: \.id) { meal in
                    MealCardView(selectedMeal: $selectedMeal, meal: meal)
                }
            }
            .padding()
        }
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, placement: .navigationBarDrawer)
        .task {
            // Load the meals in the selected category
            do {
                let mealPreviewData: MealPreviewData = try await vm.loadRemoteJSON(urlString: vm.baseURL + "filter.php?c=\(category)")
                mealPreviews = mealPreviewData.mealPreviews
            } catch {
                print("Error loading data: \(error.localizedDescription)")
            }
        }
        .sheet(item: $selectedMeal, onDismiss: {
            // Re-enables the idle timer, so the device dims its screen and/or sleeps, as appropriate
            UIApplication.shared.isIdleTimerDisabled = false
        }) { meal in
            RecipeView(mealID: meal.id)
        }
    }
}

#Preview {
    MealListView(category: "Dessert")
        .environmentObject(ViewModel())
}
