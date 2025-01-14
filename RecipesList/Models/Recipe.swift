import Foundation

// MARK: - Recipes
struct Recipes: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable, Identifiable {
    let uuid: String
    let cuisine: String
    let name: String
    let photoURLLarge, photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?
    
    var id: String { uuid }

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case uuid
        case youtubeURL = "youtube_url"
    }
}
