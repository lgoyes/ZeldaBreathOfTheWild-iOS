//
//  ItemListRowView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import SwiftUI

fileprivate struct ItemListRowViewStyle {
    struct ItemImage {
        static let sideLength = 80.0
        static let cornerRadius = 24.0
        static let backgroundColor = Color.gray
        static let distanceToTitle = 18.0
    }
    struct Title {
        static let font = Font.title2
        static let fontWeight = Font.Weight.bold
    }
    static let padding = 8.0
}

struct ItemListRowView: View {
    @Binding var title: String
    @Binding var imageURL: URL?
    var body: some View {
        HStack {
            AsyncImage(url: imageURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(
                width: ItemListRowViewStyle.ItemImage.sideLength,
                height: ItemListRowViewStyle.ItemImage.sideLength)
            .background(ItemListRowViewStyle.ItemImage.backgroundColor)
            .cornerRadius(ItemListRowViewStyle.ItemImage.cornerRadius)
            .padding(.trailing, ItemListRowViewStyle.ItemImage.distanceToTitle)
            
            Text(title)
                .font(ItemListRowViewStyle.Title.font)
                .fontWeight(ItemListRowViewStyle.Title.fontWeight)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(ItemListRowViewStyle.padding)
    }
}

struct ItemListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListRowView(title: .constant("Any-title"), imageURL: .constant(URL(string: "https://botw-compendium.herokuapp.com/api/v2/entry/hot-footed_frog/image")))
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
