//
//  NonConsumableItemsService.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 13/09/22.
//

import Foundation

class NonConsumableItemsService: BaseCategoryItemsService<APINonConsumableItemsResponse> {
    private let apiNonConsumableItemsResponseCategoryItemsMapper: APINonConsumableItemsResponseCategoryItemsMapper
    
    init(apiNonConsumableItemsResponseCategoryItemsMapper: APINonConsumableItemsResponseCategoryItemsMapper,
         webClient: WebClientProtocol,
         networkRouter: NetworkRoutable) {
        self.apiNonConsumableItemsResponseCategoryItemsMapper = apiNonConsumableItemsResponseCategoryItemsMapper
        super.init(webClient: webClient, networkRouter: networkRouter)
    }
    
    override func getValidCategories() -> [Category] {
        return [.equipment, .treasure, .treasure, .materials, .monsters]
    }
    
    override func map(apiResponse: APINonConsumableItemsResponse) -> CategoryItems {
        return self.apiNonConsumableItemsResponseCategoryItemsMapper.map(input: apiResponse)
    }
}
