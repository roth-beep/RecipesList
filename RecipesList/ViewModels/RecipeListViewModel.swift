import Combine
import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {
    // Internal
    @Published var recipes = [Recipe]()
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    
    // Private
    private let model: RecipeListModeling
    private var cancellables = Set<AnyCancellable>()
    
    init(model: RecipeListModeling) {
        self.model = model
        
        subscribe()
    }
    
    func start() async {
        // indicate we are loading
        startLoading()
        
        // begin getting our data
        do {
            try await model.start()
        } catch let error {
            print("Error source: RecipeListViewModel start: \(error.localizedDescription)")
            
            self.stopLoading()
            self.showError()
        }
        
        // indicate we are done loading
        self.stopLoading()
    }
    
    func refresh() async {
        do {
            try await model.start()
        } catch let error {
            print("Error source: RecipeListViewModel refresh: \(error.localizedDescription)")
        }
        
    }
    
    private func subscribe() {
        model
            .recipesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] recipes in
                self?.recipes = recipes
            }.store(in: &cancellables)
    }
    
    // MARK: - State
    private func startLoading() {
        isLoading = true
    }
    
    private func stopLoading() {
        isLoading = false
    }
    
    func showError() {
        showAlert = true
    }

    func hideError() {
        showAlert = false
    }
    
}
