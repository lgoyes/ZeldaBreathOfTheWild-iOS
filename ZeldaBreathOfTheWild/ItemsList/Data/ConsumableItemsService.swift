//
//  ConsumableItemsService.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import Foundation

class ConsumableItemsService: BaseCategoryItemsService<APIConsumableItemsResponse> {
    private let apiConsumableItemsResponseCategoryItemsMapper: APIConsumableItemsResponseCategoryItemsMapper
    
    init(apiConsumableItemsResponseCategoryItemsMapper: APIConsumableItemsResponseCategoryItemsMapper, webClient: WebClientProtocol, networkRouter: NetworkRoutable) {
        self.apiConsumableItemsResponseCategoryItemsMapper = apiConsumableItemsResponseCategoryItemsMapper
        super.init(webClient: webClient, networkRouter: networkRouter)
    }
    
    override func getValidCategories() -> [Category] {
        return [.creatures]
    }
    
    override func map(apiResponse: APIConsumableItemsResponse) -> CategoryItems {
        return self.apiConsumableItemsResponseCategoryItemsMapper.map(input: apiResponse)
    }
}
