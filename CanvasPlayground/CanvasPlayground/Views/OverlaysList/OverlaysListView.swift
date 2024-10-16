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

    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        ZStack {
            Color.mainBackground
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavigationBar()

                HeaderCategories()

                OverlaysList()
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

// MARK: - OverlaysList

extension OverlaysListView {

    @ViewBuilder
    private func OverlaysList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.selectedCategoryItems, id: \.self) { item in
                    WebImage(url: URL(string: item.sourceUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            viewModel.setSelectedItem(item)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}
