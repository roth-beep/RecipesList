import Foundation

protocol RecipeFetching {
    func fetchAllRecipes() async throws -> [Recipe]
}


final class RecipeFetcher: RecipeFetching {
    
    // NOTE: Not passing in a path. Do not enable a user of this method to do so. Makes testing easier but should be with an interception layer instead.
    // Private
    private let path: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    private let malformedResultPath: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    private let emptyResultPath: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    
    func fetchAllRecipes() async throws -> [Recipe] {
        let urlRequest = try createURLRequest()
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        guard let recipes = try? JSONDecoder().decode(Recipes.self, from: data) else {
            throw URLError(.cannotDecodeRawData)
        }
        
        return recipes.recipes
    }
    
    private func createURLRequest() throws -> URLRequest {
        guard let url = URL(string: path) else {
            throw URLError(.badURL)
        }
        
        return URLRequest(url: url)
    }
}
