//
//  ContentView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import SwiftUI

struct ContentView: View {
    
    var categoryListViewBuilder: CategoryListViewBuilder

    init() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        
        categoryListViewBuilder = CategoryListViewBuilder()
    }
    
    var body: some View {
        NavigationView {
            categoryListViewBuilder.build()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
