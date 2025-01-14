import Foundation

enum RecipeError: Error, LocalizedError {
    case createURL
    case fetchData
    case decodeFail
    
    var errorDescription: String? {
        switch self {
        case .createURL:
            return "Failed creating URL."
        case .fetchData:
            return "Failed to fetch data."
        case .decodeFail:
            return "Did the model change?"
        }
    }
}
