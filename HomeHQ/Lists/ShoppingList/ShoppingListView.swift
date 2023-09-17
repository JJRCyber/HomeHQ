//
//  ShoppingListView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 27/8/2023.
//

import SwiftUI

struct ShoppingListView: View {
    
    @StateObject var viewModel = ShoppingListViewModel()
    
    //MARK: View
    // Shopping list with text field at the top before list of
    // items from view model. Buttons allow modification of quantity and completion
    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            // View switch based on loading state of viewModel
            switch viewModel.loadingState {
            case .idle, .loading:
                LoadingView()
            case .loaded:
                listView
            case .error:
                MissingHomeView()
            }
            
        }
        .task {
            await viewModel.loadData()
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
            Button("Ok", role: .cancel) { }
        }
        .frame(maxHeight: 250)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding()
    }
    
    //MARK: View Components
    var header: some View {
        HStack{
            Spacer()
            Text("Shopping List")
                .foregroundColor(Color("PrimaryText"))
                .padding(.vertical)
                .padding(.leading)
            Spacer()
        }
    }
    
    // Displays a text field as the first item on list
    // Will add a new item to the shopping list on submit of text field
    // Loops over all items in shopping list with custom view for each
    var listView: some View {
        List {
            TextField("Add Item", text: $viewModel.newItemName)
                .listRowBackground(Color.clear)
                .foregroundColor(Color("PrimaryText"))
                .font(.callout)
                .overlay(alignment: .trailing, content: {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .opacity(viewModel.isValidEntry() ? 0.0 : 1.0)
                })
                .onSubmit {
                    viewModel.addItem()
                }
            ForEach(viewModel.shoppingList) { item in
                ShoppingListRowView(viewModel: viewModel, item: item)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }
            .onDelete(perform: viewModel.deleteItem)
        }
        .listStyle(.plain)
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
