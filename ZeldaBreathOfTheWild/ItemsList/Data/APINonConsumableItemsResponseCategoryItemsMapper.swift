//
//  APINonConsumableItemsResponseCategoryItemsMapper.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import Foundation

protocol APINonConsumableItemsResponseCategoryItemsMapper {
    func map(input: APINonConsumableItemsResponse) -> CategoryItems
}

struct DefaultAPINonConsumableItemsResponseCategoryItemsMapper: APINonConsumableItemsResponseCategoryItemsMapper {
    
    private let apiNonFoodItemNonFoodItemMapper = APINonFoodItemNonFoodItemMapper()
    
    func map(input: APINonConsumableItemsResponse) -> CategoryItems {
        let nonFoodItems = input.data.map { apiNonFoodItemNonFoodItemMapper.map(input: $0) }
        return CategoryItems(food: [], nonFood: nonFoodItems)
    }
}
