//
//  LoadableListView.swift
//  Fav8
//
//  Created by Administrator on 12/5/22.
//

import Foundation
import SwiftUI

protocol LoadableView {}

extension LoadableView where Self: View {

    /**
     Reusable empty view used to perform actions when loading content into a view.

     - Parameter performing: The callback to perform when the view appears.

     ```swift
     switch viewAdapter.loadableItem {
     case .notRequested:
        notRequestedView(performing: viewAdapter.fetchData)
        // ...
     }
     ```
     */
    @ViewBuilder func notRequestedView(performing action: @escaping () -> Void) -> some View {

        Text("")
            .onAppear(perform: action)
    }
}

protocol LoadableListView: LoadableView {}

extension LoadableListView where Self: View {

    /**
     Returns a progress view covering the entire available space.

     ```swift
     switch viewAdapter.loadableItem {
     case .isLoading:
        loadingListView
        // ...
     }
     ```
     */
    @ViewBuilder var loadingListView: some View {

        GeometryReader {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .frame(maxWidth: .infinity)
                .frame(height: $0.size.width)
        }
    }

    /**
     Returns a padded view for presenting empty lists,

     - Parameter content: A view builder producing the desired empty list view content.

     ```swift
     emptyListView {
        Text("Good job!")
            .font(.h1)
     }
     ```
     */
    @ViewBuilder func emptyListView<Content: View>(@ViewBuilder content: @escaping () -> Content)
        -> some View
    {

        GeometryReader {
            content()
                .frame(maxWidth: .infinity, minHeight: $0.size.width)
                .padding(10)
        }
    }
}
