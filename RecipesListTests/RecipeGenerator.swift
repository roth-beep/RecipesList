@testable import RecipesList

final class RecipeGenerator {
    static func createMockRecipes() -> [Recipe] {
        let recipe1 = Recipe(uuid: "1", cuisine: "American", name: "Hamburger", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil)
        let recipe2 = Recipe(uuid: "2", cuisine: "British", name: "Chips", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil)
        let recipe3 = Recipe(uuid: "3", cuisine: "Canadian", name: "Poutine", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil)
        
        return [recipe1, recipe2, recipe3]
    }
}
