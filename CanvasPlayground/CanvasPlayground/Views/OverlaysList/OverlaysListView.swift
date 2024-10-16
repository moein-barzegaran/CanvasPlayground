//
//  OverlaysListView.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import SwiftUI

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
