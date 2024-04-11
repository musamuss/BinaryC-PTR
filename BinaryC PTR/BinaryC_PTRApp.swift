import SwiftUI

@main
struct BinaryC_PTRApp: App {
    var body: some Scene {
        WindowGroup {
			return PatternsScreen(viewModel: PatternsScreenVM())
        }
    }
}
