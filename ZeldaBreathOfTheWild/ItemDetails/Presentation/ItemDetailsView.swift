//
//  ItemDetailsView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import SwiftUI

fileprivate struct ItemDetailsViewConstant {
    static let commonLocationsTitle = "Common Locations"
    static let locationsImageName = "map"
}

fileprivate struct ItemDetailsViewStyle {
    struct Category {
        static let font = Font.title3
    }
    struct ItemImage {
        static let cornerRadius = 24.0
        static let verticalPadding = 16.0
        static let backgroundColor = Color.gray
        static let sideLength = 160.0
    }
    struct Description {
        static let distanceToDivider = 24.0
    }
    struct Divider {
        static let color = Color(hex: 0xe1e2e3)
        static let distanceToCommonLocationsTitle = 24.0
    }
    struct LocationsTitle {
        static let font = Font.title2
        static let fontWeight = Font.Weight.bold
        static let distanceToLocationsContent = 8.0
    }
    struct Locations {
        static let textColor = Color(hex: 0x65686a)
        static let font = Font.body
        static let fontWeight = Font.Weight.light
    }
    struct Main {
        static let backgroundColor = Color(hex: 0xfafafa)
        static let horizontalPadding = 24.0
    }
}

struct ItemDetailsView: View {
    let viewModel: ItemDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text(viewModel.category)
                    .font(ItemDetailsViewStyle.Category.font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                AsyncImage(url: viewModel.imageURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, minHeight: ItemDetailsViewStyle.ItemImage.sideLength, maxHeight: ItemDetailsViewStyle.ItemImage.sideLength)
                .background(ItemDetailsViewStyle.ItemImage.backgroundColor)
                .cornerRadius(ItemDetailsViewStyle.ItemImage.cornerRadius)
                .padding(.vertical, ItemDetailsViewStyle.ItemImage.verticalPadding)
                
                Text(viewModel.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                    .padding(.bottom, ItemDetailsViewStyle.Description.distanceToDivider)
                
                if viewModel.shouldShowCommonLocations() {
                    Divider()
                        .background(ItemDetailsViewStyle.Divider.color)
                        .padding(.bottom, ItemDetailsViewStyle.Divider.distanceToCommonLocationsTitle)
                    
                    Text(ItemDetailsViewConstant.commonLocationsTitle)
                        .font(ItemDetailsViewStyle.LocationsTitle.font)
                        .fontWeight(ItemDetailsViewStyle.LocationsTitle.fontWeight)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, ItemDetailsViewStyle.LocationsTitle.distanceToLocationsContent)
                    
                    HStack {
                        Image(systemName: ItemDetailsViewConstant.locationsImageName)
                        Text(viewModel.commonLocations)
                            .font(ItemDetailsViewStyle.Locations.font)
                            .fontWeight(ItemDetailsViewStyle.Locations.fontWeight)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(ItemDetailsViewStyle.Locations.textColor)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, ItemDetailsViewStyle.Main.horizontalPadding)
            .navigationTitle(Text(viewModel.name))
        }
        .background(ItemDetailsViewStyle.Main.backgroundColor)
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static let viewModel = ItemDetailsViewModel(
        name: "Name",
        category: "Category",
        description: "Some description, which is supposed to be large enough to take multiple lines",
        commonLocations: ["Medellin", "Bogota"],
        imageURL: URL(string:"https://botw-compendium.herokuapp.com/api/v2/entry/hot-footed_frog/image"))
    static var previews: some View {
        ItemDetailsView(viewModel: viewModel)
    }
}
