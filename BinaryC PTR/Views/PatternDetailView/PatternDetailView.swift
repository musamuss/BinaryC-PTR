import Foundation
import SwiftUI

struct PatternDetailView: View {

	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@ObservedObject var viewModel: PatternDetailVM
	
	var body: some View {
		NavigationView {
			ZStack {
				LinearGradientView()
				VStack {
					Text(viewModel.pattern.name)
						.font(.interBold(size: 35))
					VStack(
						spacing: 32,
						content: {
							ScrollView {
								Text(viewModel.pattern.description)
									.lineLimit(nil)
									.font(.interRegular(size: 15))
							}
							.frame(maxHeight: self.calculateTextHeight())
							Image(viewModel.pattern.imageName, bundle: nil)
								.resizable()
								.frame(height: 201)
								.background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
						}
					)
					Spacer()
					bottomButtons()
				}
				.padding(.horizontal, 24)
			}
		}
		.navigationBarHidden(true)
	}

	private func bottomButtons() -> some View {
		return VStack(
			spacing: 8,
			content: {
				Button(action: {
					viewModel.favoriteTapped()
				}) {
					Text(viewModel.favoriteButtonText)
						.font(.interRegular(size: 15))
						.foregroundColor(.black)
				}
				.frame(height: 60)
				.frame(maxWidth: .infinity)
				.background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
				Button(action: {
					self.presentationMode.wrappedValue.dismiss()
				}) {
					Text("BACK TO LIST")
						.font(.interRegular(size: 15))
						.foregroundColor(.black)
						.frame(maxWidth: .infinity)
				}
				.frame(height: 60)
				.frame(maxWidth: .infinity)
				.background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
			}
		)
	}

	func calculateTextHeight() -> CGFloat {
		let text = viewModel.pattern.description
		let font = UIFont.systemFont(ofSize: 15)
		let textWidth = UIScreen.main.bounds.width - 32
		let boundingBox = CGSize(width: textWidth, height: .greatestFiniteMagnitude)
		let size = text.boundingRect(with: boundingBox, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).size
		return size.height > 346 ? 346 : size.height
	}
}

#Preview {
	PatternDetailView(
		viewModel: PatternDetailVM(
			pattern: Pattern(
				id: 0,
				name: "PatternName",
				description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
				imageName: "ascending-triangle"
			)
		)
	)
}
