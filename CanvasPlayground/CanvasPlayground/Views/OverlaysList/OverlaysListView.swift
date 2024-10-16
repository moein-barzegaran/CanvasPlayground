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

        }
    }
}
