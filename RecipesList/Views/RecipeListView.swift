
import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel: RecipeListViewModel
    
    init(viewModel: RecipeListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading")
            } else {
                // TODO: Improvement would be to add the refreshable and ScrollView to the RecipeCardList Non Empty View until SwiftUI fixes alignment issues with ScrollView
                ScrollView {
                    RecipeCardListView(recipes: $viewModel.recipes)
                }.scrollIndicators(.hidden)
            }
        }
        .task {
            await viewModel.start()
        }
        .refreshable {
            await viewModel.refresh()
        }
        .alert("Sorry user I placed a bad endpoint in here but you can pull to refresh to act like something is happening.",
               isPresented: $viewModel.showAlert) {
            Button("Okay", role: .cancel) { }
        }
    }
}


struct RecipeCardListView: View {
    @Binding var recipes: [Recipe]
        
    var body: some View {
        if recipes.isEmpty {
            // EMPTY VIEW
            Text("No Recipes Found.")
        } else {
            LazyVStack {
                ForEach(recipes) { recipe in
                    RecipeCardView(recipe: recipe)
                }
            }
        }
    }
}
