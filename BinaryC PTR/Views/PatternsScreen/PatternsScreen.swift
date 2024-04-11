import SwiftUI

struct PatternsScreen: View {
	@ObservedObject var viewModel: PatternsScreenVM
	@State private var firstViewIsOn = false
	
	var body: some View {
		NavigationView {
			ZStack {
				LinearGradientView()
				VStack {
					SegmentedPicker(
						viewModel.screens,
						selectedIndex: $viewModel.selectedScreen,
						selectionAlignment: .center,
						content: { item, isSelected in
							Text(item)
								.font(.interBold(size: 32))
								.scaledToFit()
								.minimumScaleFactor(0.5)
								.foregroundColor(isSelected ? Color.black : Color.gray )
								.padding(.horizontal, 8)
						}
					)
					.animation(.easeInOut, value: viewModel.selectedScreen)
					HStack(content: {
						Button(action: {
							print("Button pressed")
						}) {
							Text("PnL")
								.font(.interRegular(size: 15))
								.foregroundColor(.white)
						}
						.frame(width: 99, height: 60)
						.background(RoundedRectangle(cornerRadius: 15).fill(Color.bluePTR))
						Spacer()
					})
					Spacer(minLength: 33)
					scrollView()
				}
				.padding()
			}
		}
		.navigationBarHidden(true)
	}

	private func scrollView() -> some View {
		return ScrollView(.vertical, showsIndicators: false) {
			LazyVStack(
				spacing: 16,
				content: {
					ForEach(viewModel.filteredPatterns, id: \.self) { pattern in
						Button {
							viewModel.selectedPattern = pattern
							firstViewIsOn.toggle()
						} label: {
							Text(pattern.name)
								.font(.interRegular(size: 15))
								.foregroundColor(.white)
								.frame(maxWidth: .infinity)
						}
						.frame(height: 74)
						.background(RoundedRectangle(cornerRadius: 15).fill(Color.bluePTR))
					}
				}
			).background(
				NavigationLink("", isActive: $firstViewIsOn) {
					PatternDetailView(
						viewModel: PatternDetailVM(
							pattern: viewModel.selectedPattern
						)
					)
				}
			)
		}
	}
}

struct PatternsScreen_Previews: PreviewProvider {
	static var previews: some View {
		PatternsScreen(viewModel: PatternsScreenVM())
	}
}
