import SwiftUI

struct RecipeCardView: View {
    @StateObject private var viewModel: RecipeCardViewModel
    
    init(recipe: Recipe) {
        self._viewModel = StateObject(wrappedValue: RecipeCardViewModel(recipe: recipe))
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 32) {
                recipeImage()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.getName())
                        .font(.title3)
                    Text(viewModel.getCuisine())
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Divider()
        }
        .task {
            await viewModel.start()
        }
    }
    
    @ViewBuilder
    func recipeImage() -> some View {
        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
        } else {
            ProgressView()
                .frame(width: 75, height: 75)
        }
    }
}
