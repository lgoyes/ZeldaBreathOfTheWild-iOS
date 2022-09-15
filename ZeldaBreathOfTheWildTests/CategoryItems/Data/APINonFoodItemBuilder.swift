//
//  APINonFoodItemBuilder.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 15/09/22.
//

import Foundation
@testable import ZeldaBreathOfTheWild

struct APINonFoodItemBuilder {
    struct Constant {
        static let someCategory = "creatures"
        static let someLocation = "any-location"
        static let someDescription = "any-description"
        static let someId = 6
        static let someImage = "any-image"
        static let someName = "any-name"
        static let someDrop = "any-drop"
    }

    static func build() -> APINonFoodItem {
        return APINonFoodItem(
            category: Constant.someCategory,
            commonLocations: [Constant.someLocation],
            description: Constant.someDescription,
            drops: [Constant.someDrop],
            id: Constant.someId,
            image: Constant.someImage,
            name: Constant.someName)
    }
}
