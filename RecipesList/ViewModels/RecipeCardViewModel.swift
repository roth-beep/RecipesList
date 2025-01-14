import Combine
import UIKit

@MainActor
final class RecipeCardViewModel: ObservableObject {
    @Published private(set) var image: UIImage?
    
    private let imageLoader = ImageRecipeLoader()
    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func start() async  {
        guard image == nil else { return }
        guard let url = recipe.photoURLSmall else {
            image = UIImage(systemName: "fork.knife.circle.fill")
            return
        }
        
        // fetch image
        do {
            let loadedImage = try await imageLoader.loadImage(from: url)
            self.image = loadedImage
        } catch {
            print("Error loading image: \(error)")
        }
        
    }
    
    func getName() -> String {
        recipe.name
    }
    
    func getCuisine() -> String {
        recipe.cuisine
    }
    
}
