import Combine

protocol RecipeListModeling {
    var recipesPublisher: PassthroughSubject<[Recipe], Never> { get }
    
    func start() async throws
}

final class RecipeListModel: RecipeListModeling {
    // Internal
    let recipesPublisher = PassthroughSubject<[Recipe], Never>()

    // Private
    private let fetcher: RecipeFetching
    
    init(fetcher: RecipeFetching = RecipeFetcher()) {
        self.fetcher = fetcher
    }
    
    func start() async throws {
        let recipes = try await fetcher.fetchAllRecipes()
        
        recipesPublisher.send(recipes)
    }
}
