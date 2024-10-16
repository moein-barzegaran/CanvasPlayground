//
//  OverlaysListView.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct OverlaysListView: View {

    @StateObject var viewModel = OverlaysListViewModel()

    var body: some View {
        ZStack {
            Color.mainBackground
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavigationBar()
            }
        }
    }
}

// MARK: - NavigationBar

extension OverlaysListView {

    @ViewBuilder
    private func NavigationBar() -> some View {
        ZStack {
            HStack {
                Spacer()

                Button {
                    // TODO: 🔥 Add dismiss action
                } label: {
                    Image(systemName: "xmark")
                        .renderingMode(.template)
                        .foregroundStyle(Color.white)
                        .frame(
                            width: DesignSystem.Size.closeButtonSize,
                            height: DesignSystem.Size.closeButtonSize
                        )
                        .padding(4)
                        .background(
                            Circle()
                                .fill(Color.bgSecondary)
                        )
                        .padding(DesignSystem.Paddings.defaultPadding)
                }

            }

            Text("Stickers")
                .foregroundStyle(Color.white)
                .font(.headline)
        }
    }
}

// MARK: - HeaderCategories

extension OverlaysListView {

    @ViewBuilder
    private func HeaderCategories() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.overlays, id: \.self) { category in
                    VStack {
                        WebImage(url: URL(string: category.thumbnailUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)

                        Text(category.title)
                            .foregroundStyle(Color.white)
                            .font(.subheadline)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(viewModel.selectedCategory == category ? Color.bgSecondary : .clear)
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.setSelectedOverlayCategory(category)
                        }
                    }
                }
            }
            .padding([.bottom, .horizontal])
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
