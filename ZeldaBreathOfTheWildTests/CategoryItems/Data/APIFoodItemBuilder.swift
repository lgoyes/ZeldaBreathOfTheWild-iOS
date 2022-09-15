//
//  APIFoodItemBuilder.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 15/09/22.
//

import Foundation
@testable import ZeldaBreathOfTheWild

struct APIFoodItemBuilder {
    struct Constant {
        static let someCategory = "creatures"
        static let someLocation = "any-location"
        static let someCookingEffect = "any-cooking-effect"
        static let someDescription = "any-description"
        static let someHeartsRecovered = 5
        static let someId = 6
        static let someImage = "any-image"
        static let someName = "any-name"
    }
    
    static func build() -> APIFoodItem {
        return APIFoodItem(
            category: Constant.someCategory,
            commonLocations: [Constant.someLocation],
            cookingEffect: Constant.someCookingEffect,
            description: Constant.someDescription,
            heartsRecovered: Constant.someHeartsRecovered,
            id: Constant.someId,
            image: Constant.someImage,
            name: Constant.someName)
    }
}
