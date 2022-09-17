//
//  CategoryItemsListView.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 15/09/22.
//

import SwiftUI

struct CategoryItemListRowView: View {
    private struct Constant {
        static let imageSide = 80.0
    }
    
    let title: String
    let imageURL: URL?
    var body: some View {
        HStack {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: Constant.imageSide, height: Constant.imageSide)
            .background(Color.gray)
            .cornerRadius(24)
            .padding(.trailing, 24)
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding(.vertical, 8)
    }
}

struct CategoryItemsListView: View {
    private struct Constant {
        static let searchBarPrompt = "Search..."
    }
    
    let category: Category
    @ObservedObject var viewModel: CategoryItemsListViewModel
    init(category: Category, viewModel: CategoryItemsListViewModel) {
        self.category = category
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.items, id: \.id) { item in
                    NavigationLink {
                        ItemDetailsView(name: item.name, category: item.category.rawValue, description: item.description, commonLocations: item.commonLocations, imageURL: URL(string: item.image))
                    } label: {
                        CategoryItemListRowView(title: item.name, imageURL: URL(string: item.image))
                    }
                    .listRowSeparator(.hidden, edges: .bottom)
                }
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchText, prompt: Constant.searchBarPrompt)
        }
        .navigationTitle(Text(viewModel.title))
    }
}

struct CategoryItemsListView_Previews: PreviewProvider {
    static let viewModel = CategoryItemsListViewModel(getTitleForCategoryUseCase: GetTitleForCategoryUseCase(repository: CategoryTitleRepository()), category: .treasure)
    static var previews: some View {
        CategoryItemsListView(category: .creatures, viewModel: viewModel)
    }
}
