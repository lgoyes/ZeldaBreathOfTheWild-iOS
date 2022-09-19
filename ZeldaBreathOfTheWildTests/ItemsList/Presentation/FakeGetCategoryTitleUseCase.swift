//
//  FakeGetCategoryTitleUseCase.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import Foundation
@testable import ZeldaBreathOfTheWild

class FakeGetCategoryTitleUseCase: GetCategoryTitleUseCaseProtocol {
    var fakeTitle = ""
    func getTitle(for category: ZeldaBreathOfTheWild.Category) -> String {
        return fakeTitle
    }
}
