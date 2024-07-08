# What's Cooking

## Features

- Browse  by food category
- Search for recipes within a category
- View recipe source web sites (if applicable), without leaving the app
- Watch instructions on YouTube (if applicable), without leaving the app
- Device doesn’t sleep while recipes are displayed


## Details

- Built using Swift and SwiftUI
- `UIViewControllerRepresentable` was used to make `SFSafariViewController` available in SwiftUI
- `LazyVGrid` was used in `CategoryListView` and `MealListView`, to make the content adapt to the size and orientation of the device display
- JSON data was decoded from multiple endpoints on TheMealDB’s API (https://themealdb.com/api.php)


## Challenges

<details>
  <summary><b>Ingredients & Measurements</b></summary>
  </br>

The API handles recipe ingredients and measurements in a fairly unwieldy way; it contains 20 fields each for ingredients and measurements, each with an optional value. This makes for a fairly complicated data model, if the properties are added individually, which in turn makes working with the data fairly complicated.

I considered different potential solutions to this problem, and searched for ideas that could help simplify the code so that it would be straightforward to work with inside views. I ended up creating a new type called `Ingredient` that holds `name` and `measure` properties. With that and what I learned from searching for a solution, I created a custom decoder that iterates over the API values by their dictionary keys, appending non-empty values to an array of type `Ingredient`, which I assigned to a model property of the same type. 

With that, ingredients were as easy to work with inside views as any other property.

</details>

<details>
  <summary><b>Instructions Spacing</b></summary>
  </br>

While working on `RecipeView`, I noticed that the instructions had varying numbers of line breaks between paragraphs, which made some recipes look very unpolished.

To solve the problem, I tried replacing all single and double line breaks with a double line break, using `replacingOccurrences(of: “\n”, with: “\n\n”)`. When that didn’t work, I went to the API and looked at multiple recipes. What I found was that most recipes used either `\r\n` or `\r\n\r\n` for their line breaks, which is clearly more complicated. After searching for a solution and learning just enough about regular expressions to solve the problem, I found an elegant solution: `replacingOccurrences(of: "[\r\n]+", with: "\n\n", options: .regularExpression)`. 

That solved the problem, and all recipes now have the same amount of spacing between paragraphs, for a much more polished appearance.
  
</details>
