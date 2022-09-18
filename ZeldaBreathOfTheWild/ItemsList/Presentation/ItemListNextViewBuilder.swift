//
//  ItemListNextViewBuilder.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import SwiftUI

struct ItemListNextViewBuilder {
    let getCategoryTitleUseCase: GetCategoryTitleUseCase
    
    init(getCategoryTitleUseCase: GetCategoryTitleUseCase) {
        self.getCategoryTitleUseCase = getCategoryTitleUseCase
    }
    
    func build(name: String, category: Category, description: String, commonLocations: [String], imageURL: URL?) -> ItemDetailsView {
        let viewModel = ItemDetailsViewModel(
            name: name,
            category: getCategoryTitleUseCase.getTitle(for: category),
            description: description,
            commonLocations: commonLocations,
            imageURL: imageURL)
        let nextView = ItemDetailsView(viewModel: viewModel)
        return nextView
    }
}
