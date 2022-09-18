//
//  APIConsumableItemsResponseCategoryItemsMapper.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 14/09/22.
//

import Foundation

protocol APIConsumableItemsResponseCategoryItemsMapper {
    func map(input: APIConsumableItemsResponse) -> CategoryItems
}

struct DefaultAPIConsumableItemsResponseCategoryItemsMapper: APIConsumableItemsResponseCategoryItemsMapper {
    
    private let apiFoodItemFoodItemMapper = APIFoodItemFoodItemMapper()
    private let apiNonFoodItemNonFoodItemMapper = APINonFoodItemNonFoodItemMapper()
    
    func map(input: APIConsumableItemsResponse) -> CategoryItems {
        let foodItems = input.data.food.map { apiFoodItemFoodItemMapper.map(input: $0) }
        let nonFoodItems = input.data.nonFood.map { apiNonFoodItemNonFoodItemMapper.map(input: $0) }
        return CategoryItems(food: foodItems, nonFood: nonFoodItems)
    }
}
