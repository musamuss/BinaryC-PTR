import SwiftUI

class PatternsScreenVM: ObservableObject {
	
	@Published var selectedScreen = 0 {
		didSet {
			filterPatterns()
		}
	}
	@Published var selectedPattern: Pattern
	@Published  private(set) var filteredPatterns: [Pattern] = []
	private(set) var screens = ["PATTERNS", "FAVORITES"]

	private var patterns: [Pattern] = []
	private let storage = DataStorage.shared

	init() {
		self.patterns = storage.loadJson()
		self.filteredPatterns = patterns
		self.selectedPattern = patterns.first!
	}

	private func filterPatterns() {
		if selectedScreen == 1 {
			let favoritesID = storage.getFavoritesID()
			self.filteredPatterns = filteredPatterns.filter({ favoritesID.contains($0.id) })
		} else {
			self.filteredPatterns = patterns
		}
	}

}
