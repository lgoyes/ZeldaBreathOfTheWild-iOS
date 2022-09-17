//
//  ItemDetailsView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import SwiftUI

struct ItemDetailsView: View {
    private struct Constant {
        static let commonLocationsTitle = "Common Locations"
        static let mainBackgroundColor = Color(hex: 0xfafafa)
        static let locationsSeparator = ", "
        static let dividerColor = Color(hex: 0xe1e2e3)
        static let locationsColor = Color(hex: 0x65686a)
        static let imageHeight = 160.0
    }
    
    let name: String
    let category: String
    let description: String
    let commonLocations: [String]
    let imageURL: URL?
    var body: some View {
        ScrollView {
            VStack {
                Text(category)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, minHeight: Constant.imageHeight, maxHeight: Constant.imageHeight)
                .background(Color.gray)
                .cornerRadius(24)
                .padding(.vertical, 16)
                
                Text(description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(.body)
                    .padding(.bottom, 24)
                    
                Divider()
                    .background(Constant.dividerColor)
                    .padding(.bottom, 24)
                
                Text(Constant.commonLocationsTitle)
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                
                HStack {
                    Image(systemName: "map")
                    Text(commonLocations.joined(separator: Constant.locationsSeparator).uppercased())
                        .font(.body)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Constant.locationsColor)
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .navigationTitle(Text(name))
        }
        .background(Constant.mainBackgroundColor)
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailsView(name: "Name", category: "Category", description: "Some description, which is supposed to be large enough to take multiple lines", commonLocations: ["Medellin", "Bogota"], imageURL: URL(string: "https://botw-compendium.herokuapp.com/api/v2/entry/hot-footed_frog/image"))
    }
}
