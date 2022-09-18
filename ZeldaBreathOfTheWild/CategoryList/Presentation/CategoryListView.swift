//
//  CategoryListView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import SwiftUI

fileprivate struct CategoryListViewConstant {
    static let navigationBarTitle = "Categories"
}

fileprivate struct CategoryListViewStyle {
    static let mainBackgroundColor = Color(hex: 0xfafafa)
}

struct CategoryListView: View {
    let viewModel: CategoryListViewModel
    
    var body: some View {
        ZStack {
            CategoryListViewStyle.mainBackgroundColor.ignoresSafeArea()
            
            VStack {
                ForEach(viewModel.categories, id: \.self) { category in
                    CategoryCardView(
                        title: viewModel.getTitle(for: category),
                        nextView: viewModel.getNextView(for: category))
                }
            }
            .padding()
            .navigationTitle(Text(CategoryListViewConstant.navigationBarTitle))
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let titleRepository = CategoryTitleRepository()
        let getTitleUseCase = GetCategoryTitleUseCase(repository: titleRepository)
        let nextViewBuilder = CategoryListNextViewBuilder(titleUseCase: getTitleUseCase)
        let viewModel = CategoryListViewModel(
            categories: Category.allCases,
            cardNextViewBuilder: nextViewBuilder,
            getTitleForCategoryUseCase: getTitleUseCase)
        return CategoryListView(viewModel: viewModel)
    }
}
