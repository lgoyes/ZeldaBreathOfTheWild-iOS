//
//  ItemListView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import SwiftUI

fileprivate struct ItemListViewConstant {
    struct AlertError {
        static let title = "Error"
        static let message = "Something unexpected happened while downloading data"
    }
    static let searchBarPrompt = "Search..."
}

fileprivate struct ItemListViewStyle {
    static let listStyle = PlainListStyle()
}

struct ItemListView: View {
    @ObservedObject var viewModel: ItemListViewModel
    private let nextViewBuilder: ItemListNextViewBuilder
    
    init(viewModel: ItemListViewModel, nextViewBuilder: ItemListNextViewBuilder) {
        self.viewModel = viewModel
        self.nextViewBuilder = nextViewBuilder
    }
    
    var body: some View {
        List {
            ForEach($viewModel.items, id: \.id) { item in
                NavigationLink {
                    viewModel.getNextViewFor(item: item.wrappedValue)
                } label: {
                    ItemListRowView(
                        title: item.name,
                        imageURL: item.image)
                }
            }
        }
        .listStyle(ItemListViewStyle.listStyle)
        .searchable(text: $viewModel.searchText,
                    prompt: ItemListViewConstant.searchBarPrompt)
        .navigationTitle(Text(viewModel.title))
        .onAppear {
            viewModel.processOnAppear()
        }
        .onDisappear {
            viewModel.processOnDisappear()
        }
        .alert(isPresented: $viewModel.fetchItemsErrorAlertVisible) {
            Alert(
                title: Text(ItemListViewConstant.AlertError.title),
                message: Text(ItemListViewConstant.AlertError.message))
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    struct FakeUseCase: FetchCategoryItemsUseCaseProtocol {
        func getItems(for category: Category) async throws -> CategoryItems {
            return CategoryItems(food: [], nonFood: [])
        }
    }
    static var previews: some View {
        let titleRepository = CategoryTitleRepository()
        let titleUseCase = GetCategoryTitleUseCase(repository: titleRepository)
        let itemListNextViewBuilder = ItemListNextViewBuilder(getCategoryTitleUseCase: titleUseCase)
        let viewModel = ItemListViewModel(category: .treasure, getTitleForCategoryUseCase: titleUseCase, nextViewBuilder: itemListNextViewBuilder, fetchCategoryItemsUseCase: FakeUseCase())
        return ItemListView(viewModel: viewModel, nextViewBuilder: itemListNextViewBuilder)
    }
}
