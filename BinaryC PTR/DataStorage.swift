import Foundation

final class DataStorage {
	static let shared = DataStorage()
	private static let storageKey = "FAVORITES"
	private let defaults = UserDefaults.standard

	func getFavoritesID() -> [Int] {
		let defaults = UserDefaults.standard
		let favorites = defaults.array(forKey: DataStorage.storageKey) as? [Int]
		return favorites ?? []
	}

	func saveToFavorite(pattern: Pattern) {
		let defaults = UserDefaults.standard
		let favorites = defaults.array(forKey: DataStorage.storageKey) as? [Int]
		var favoritesNew = [Int]()
		if let favorites {
			favoritesNew = favorites
		}
		favoritesNew.append(pattern.id)
		defaults.set(favoritesNew, forKey: DataStorage.storageKey)
	}

	func removeFavorite(pattern: Pattern) {
		let defaults = UserDefaults.standard
		let favorites = defaults.array(forKey: DataStorage.storageKey) as? [Int]
		var favoritesNew = [Int]()
		if let favorites {
			favoritesNew = favorites
		}
		favoritesNew.removeAll(where: { $0 == pattern.id})
		defaults.set(favoritesNew, forKey: DataStorage.storageKey)
	}

	func loadJson() -> [Pattern] {
		if let url = Bundle.main.url(forResource: "patterns", withExtension: "json") {
			do {
				let data = try Data(contentsOf: url)
				let decoder = JSONDecoder()
				let jsonData = try decoder.decode(ResponseData.self, from: data)
				return jsonData.patterns
			} catch {
				print("error:\(error)")
			}
		}
		return []
	}
}

struct ResponseData: Decodable {
	var patterns: [Pattern]

	enum CodingKeys: String, CodingKey {
		case patterns = "chart_patterns"
	}
}
struct Pattern : Hashable, Decodable {
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case description
		case imageName = "image"
	}
	var id: Int
	var name: String
	var description: String
	var imageName: String
}
