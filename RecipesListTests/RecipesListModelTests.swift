import Combine
import Testing
@testable import RecipesList

struct RecipesListModelTests {

    @Test("Start will update the necessary data.") func start() async throws {
        let model = RecipeListModel(fetcher: RecipeFetchingMock())
                
        await confirmation(expectedCount: 1) { confirmation in
            let cancellable = model.recipesPublisher.sink { recipes in
                #expect(recipes[0].name == "Hamburger")
                #expect(recipes[1].name == "Chips")
                #expect(recipes[2].name == "Poutine")
                
                confirmation()
            }
            try! await model.start()
            
            cancellable.cancel()
        }
    }

}

final class RecipeFetchingMock: RecipeFetching {
    func fetchAllRecipes() async throws -> [Recipe] {
        RecipeGenerator.createMockRecipes()
    }
}

