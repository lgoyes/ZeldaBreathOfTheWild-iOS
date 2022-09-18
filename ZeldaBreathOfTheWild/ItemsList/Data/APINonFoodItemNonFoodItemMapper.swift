//
//  APINonFoodItemNonFoodItemMapper.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import Foundation

struct APINonFoodItemNonFoodItemMapper {
    func map(input: APINonFoodItem) -> NonFoodItem {
        return NonFoodItem(
            category: Category(rawValue: input.category)!,
            id: input.id,
            image: URL(string: input.image),
            name: input.name,
            description: input.description,
            commonLocations: input.commonLocations ?? [],
            drops: input.drops ?? [])
    }
}
