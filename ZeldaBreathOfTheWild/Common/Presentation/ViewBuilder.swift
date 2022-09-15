//
//  ViewBuilder.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import SwiftUI

protocol ViewBuilder {
    associatedtype ViewType where ViewType: View
    static func build() -> ViewType
}
