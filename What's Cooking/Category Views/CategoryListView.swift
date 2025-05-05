//
//  CategoryListView.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/6/24.
//

import SwiftUI

struct CategoryListView: View {
    @StateObject var vm = ViewModel()
    let columns = [GridItem(.adaptive(minimum: 150), spacing: 5)]
    
    @State private var categories = [Category]()
    
    // Array of Category objects, sorted alphabetically by name
    private var sortedCategories: [Category] {
        return categories.sorted(by: { $0.title < $1.title })
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(sortedCategories, id: \.id) { category in
                        CategoryCardView(category: category)
                    }
                }
                .padding()
            }
            .navigationTitle("What's Cooking?")
            .task {
                // Load all categories
                do {
                    let categoryData: CategoryData = try await vm.loadRemoteJSON(urlString: vm.baseURL + "categories.php")
                    categories = categoryData.categories
                } catch {
                    print("Error loading data: \(error.localizedDescription)")
                }
            }
        }
        .environmentObject(vm)
    }
}

#Preview {
    CategoryListView()
}
