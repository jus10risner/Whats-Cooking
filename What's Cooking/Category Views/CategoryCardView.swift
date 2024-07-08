//
//  CategoryCardView.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/6/24.
//

import SwiftUI

struct CategoryCardView: View {
    let category: Category
    
    var body: some View {
        NavigationLink {
            MealListView(category: category.title)
        } label: {
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color.clear) 
                        .overlay {
                            AsyncImage(url: URL(string: category.thumbnailURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } placeholder: {
                                ProgressView()
                            }
                        }
                }
                .aspectRatio(1.5, contentMode: .fit)
                
                Text(category.title)
                    .font(.subheadline.bold())
            }
            .padding()
            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 15))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CategoryCardView(category: Category.example)
}
