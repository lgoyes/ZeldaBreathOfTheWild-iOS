//
//  CategoryCardView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import SwiftUI

fileprivate struct CategoryCardViewConstant {
    static let chevronImageName = "chevron.right"
}

fileprivate struct CategoryCardViewStyle {
    struct Shadow {
        static let color = Color(hex: 0x65686a, opacity: 0.08)
        static let radius = 10.0
    }
    struct Title {
        static let font = Font.title
        static let fontWeight = Font.Weight.bold
    }
    static let cornerRadius = 24.0
    static let padding = 24.0
    static let backgroundColor = Color.white
}

struct CategoryCardView<TargetView: View>: View {
    let title: String
    let nextView: TargetView
    
    var body: some View {
        NavigationLink(destination: nextView) {
            HStack {
                Text(title)
                    .font(CategoryCardViewStyle.Title.font)
                    .fontWeight(CategoryCardViewStyle.Title.fontWeight)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: CategoryCardViewConstant.chevronImageName)
            }
            .frame(maxWidth: .infinity)
            .padding(CategoryCardViewStyle.padding)
            .background(CategoryCardViewStyle.backgroundColor)
            .cornerRadius(CategoryCardViewStyle.cornerRadius)
            .shadow(color: CategoryCardViewStyle.Shadow.color,
                radius: CategoryCardViewStyle.Shadow.radius)
        }
        .buttonStyle(.plain)
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(title: "Any-title", nextView: EmptyView())
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
