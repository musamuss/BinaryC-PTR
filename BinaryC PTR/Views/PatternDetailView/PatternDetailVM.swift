import Foundation

class PatternDetailVM: ObservableObject {

	private let storage = DataStorage.shared

	@Published var favoriteButtonText: String

	let pattern: Pattern

	init(pattern: Pattern) {
		self.pattern = pattern
		if storage.getFavoritesID().contains(pattern.id) {
			favoriteButtonText = "REMOVE FROM FAVORITES"
		} else {
			favoriteButtonText = "ADD TO FAVORITES"
		}
	}

	func favoriteTapped() {
		if storage.getFavoritesID().contains(pattern.id) {
			favoriteButtonText = "ADD TO FAVORITES"
			storage.removeFavorite(pattern: pattern)
		} else {
			favoriteButtonText = "REMOVE FROM FAVORITES"
			storage.saveToFavorite(pattern: pattern)
		}
	}

}
