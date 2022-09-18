//
//  CategoryAPICategoryMapper.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 14/09/22.
//

import Foundation

protocol CategoryAPICategoryMapper {
    func map(input: Category) -> APICategory
}

struct DefaultCategoryAPICategoryMapper: CategoryAPICategoryMapper {
    func map(input: Category) -> APICategory {
        let apiCategory = APICategory(rawValue: input.rawValue)!
        return apiCategory
    }
}
