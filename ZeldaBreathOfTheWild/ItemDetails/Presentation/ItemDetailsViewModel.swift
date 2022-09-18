//
//  ItemDetailsViewModel.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 17/09/22.
//

import SwiftUI

struct ItemDetailsViewModel {
    private struct Constant {
        static let locationsSeparator = ", "
    }
    var name: String
    var category: String
    var description: String
    var commonLocations: String
    var imageURL: URL?
    
    init(name: String, category: String, description: String, commonLocations: [String], imageURL: URL?) {
        self.commonLocations = commonLocations.joined(separator: Constant.locationsSeparator).uppercased()
        self.imageURL = imageURL
        self.name = name
        self.category = category
        self.description = description
    }
}
