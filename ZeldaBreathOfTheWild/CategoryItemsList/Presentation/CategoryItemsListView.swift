//
//  CategoryItemsListView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import SwiftUI

struct CategoryItemsListView: View {
    let category: Category
    var body: some View {
        VStack {
            Text("Hello, World! \(category.rawValue)")
        }
        .navigationTitle(Text("Items"))
    }
}

struct CategoryItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemsListView(category: .creatures)
    }
}
