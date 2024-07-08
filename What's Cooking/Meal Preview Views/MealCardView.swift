//
//  MealCardView.swift
//  What's Cooking
//
//  Created by Justin Risner on 7/6/24.
//

import SwiftUI

struct MealCardView: View {
    @Binding var selectedMeal: MealPreview?
    let meal: MealPreview
    
    var body: some View {
        Button {
            selectedMeal = meal
        } label: {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .foregroundStyle(Color.clear)
                    .overlay {
                        AsyncImage(url: URL(string: meal.thumbnailURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                
                Text(meal.title)
                    .font(.subheadline.bold())
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [.black.opacity(0.3), .black.opacity(0.2), .black.opacity(0.2), .clear], startPoint: .bottom, endPoint: .top))
            }
            .aspectRatio(1, contentMode: .fit)
        }
        .frame(maxHeight: 250, alignment: .top)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.secondary, lineWidth: 0.25)
                .foregroundStyle(Color.clear)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MealCardView(selectedMeal: .constant(MealPreview.example), meal: MealPreview.example)
}
