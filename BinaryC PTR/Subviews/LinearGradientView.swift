import SwiftUI
struct LinearGradientView: View {
	var body: some View {
		LinearGradient(
			gradient: Gradient(
				colors: [
					Color.blueGradientStart,
					Color.bluePTR
				]
			),
			startPoint: .top,
			endPoint: .bottom
		)
		.edgesIgnoringSafeArea(.all)
	}
}
