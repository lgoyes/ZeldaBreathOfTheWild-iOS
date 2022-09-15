//
//  CategorySelectionView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import SwiftUI

struct CategoryButtonView<TargetView: View>: View {
    let title: String
    let image: String
    let color: Color
    let nextView: TargetView
    
    var body: some View {
        NavigationLink(destination: nextView) {
            HStack {
                Text(title)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: image)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            .padding(EdgeInsets(top: 20.0, leading: 30.0, bottom: 20.0, trailing: 30.0))
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(Capsule())
        }
    }
}

struct CategorySelectionView: View {
    let buttonsInfo: [CategoryButtonInfo]
    var body: some View {
        VStack {
            ForEach(buttonsInfo, id: \.self) { buttonInfo in
                CategoryButtonView(title: buttonInfo.title, image: buttonInfo.image, color: buttonInfo.color, nextView: CategoryItemsListView(category: buttonInfo.category))
            }
        }
        .padding()
        .navigationTitle(Text("Categories"))
    }
}

struct CategorySelection_Previews: PreviewProvider {
    static let buttonsInfo = [
        CategoryButtonInfo(title: "Large text Large text Large text Large text", image: "globe", color: .red, category: .creatures),
        CategoryButtonInfo(title: "Medium text Medium text", image: "globe", color: .green, category: .creatures),
        CategoryButtonInfo(title: "Short", image: "globe", color: .yellow, category: .creatures)
    ]
    static var previews: some View {
        CategorySelectionView(buttonsInfo: buttonsInfo)
    }
}
