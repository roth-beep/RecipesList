import Combine
import Testing
@testable import RecipesList

struct RecipeListViewModelTests {

    @Test("Start success path.") func start() async throws {
        let model = RecipeListModelMockSuccess()
        let viewModel = await RecipeListViewModel(model: model)
        
        await viewModel.start()
        
        #expect(model.startIsCalled == true)
        await #expect(viewModel.isLoading == false)
        await #expect(viewModel.showAlert == false)
    }
    
    @Test("Start failure path.") func startFailure() async throws {
        let model = RecipeListModelMockFailure()
        let viewModel = await RecipeListViewModel(model: model)
        
        await viewModel.start()
        
        #expect(model.startIsCalled == true)
        await #expect(viewModel.isLoading == false)
        await #expect(viewModel.showAlert == true)
    }

}


final private class RecipeListModelMockSuccess: RecipeListModeling {
    var recipesPublisher = PassthroughSubject<[Recipe], Never>()
    var startIsCalled: Bool = false
    
    func start() async throws {
        startIsCalled = true
    }
}

final private class RecipeListModelMockFailure: RecipeListModeling {
    var recipesPublisher = PassthroughSubject<[Recipe], Never>()
    var startIsCalled: Bool = false
    
    func start() async throws {
        startIsCalled = true
        
        throw TestError.genericError
    }
}

enum TestError: Error {
    case genericError
}
