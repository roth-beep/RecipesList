import Foundation
import UIKit

// NOTE: This can be tested with some refactoring an adding a protocol around FileManager. Not doing so in sake of time.
actor ImageRecipeLoader {
    private var cache: [String: UIImage] = [:]
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    init() {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = paths[0].appendingPathComponent("ImageCache")
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    func loadImage(from urlString: String) async throws -> UIImage {
        let imageName = urlString.replacingOccurrences(of: "/", with: "_")
        
        // Check memory cache
        if let cachedImage = cache[urlString] {
            return cachedImage
        }
        
        // Check disk cache
        let imageUrl = cacheDirectory.appendingPathComponent(imageName)
        
        
        // Read from file system first
        if fileManager.fileExists(atPath: imageUrl.path) {
            if let data = try? Data(contentsOf: imageUrl),
               let image = UIImage(data: data) {
                cache[urlString] = image
                return image
            }
        }
        
        // Fetch from network
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        // Save to memory cache
        cache[urlString] = image
        
        // Save to disk cache
        try? data.write(to: imageUrl)
        
        return image
    }
}
