//
//  CategorySelectionView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import SwiftUI

fileprivate struct CategoryButtonViewConstant {
    static let shadowColor = Color(hex: 0x65686a, opacity: 0.08)
}

struct CategoryButtonView<TargetView: View>: View {
    let title: String
    let image: String
    let nextView: TargetView
    
    var body: some View {
        NavigationLink(destination: nextView) {
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leadingLastTextBaseline)
                    .padding(.bottom, 8)
                
                Image(systemName: "chevron.right")
            }
            .padding(24)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(24)
            .shadow(color: CategoryButtonViewConstant.shadowColor, radius: 10)
        }
        .buttonStyle(.plain)
    }
}

struct CategorySelectionView: View {
    private struct Constant {
        static let mainBackgroundColor = Color(hex: 0xfafafa)
    }
    let buttonsInfo: [CategoryButtonInfo]
    
    var body: some View {
        ZStack {
            Constant.mainBackgroundColor.ignoresSafeArea()
            
            VStack {
                ForEach(buttonsInfo, id: \.self) { buttonInfo in
                    CategoryButtonView(
                        title: buttonInfo.title,
                        image: buttonInfo.image,
                        nextView: CategoryItemsListView(
                            category: buttonInfo.category,
                            viewModel: CategoryItemsListViewModel(getTitleForCategoryUseCase: GetTitleForCategoryUseCase(repository: CategoryTitleRepository()), category: buttonInfo.category
                                                                 )
                        ))
                }
            }
            .padding()
            .navigationTitle(Text("Categories"))
        }
    }
}

struct CategorySelection_Previews: PreviewProvider {
    static let buttonsInfo = [
        CategoryButtonInfo(title: "Large text Large text Large text Large text", image: "globe", category: .creatures),
        CategoryButtonInfo(title: "Medium text Medium text", image: "globe", category: .creatures),
        CategoryButtonInfo(title: "Short", image: "globe", category: .creatures)
    ]
    static var previews: some View {
        CategorySelectionView(buttonsInfo: buttonsInfo)
    }
}
