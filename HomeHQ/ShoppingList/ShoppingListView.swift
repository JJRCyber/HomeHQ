//
//  ShoppingListView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 27/8/2023.
//

import SwiftUI

struct ShoppingListView: View {
    
    @StateObject var viewModel = ShoppingListViewModel()
    
    // Shopping list with text field at the top before list of
    // items from view model. Buttons allow modification of quantity and completion
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                Spacer()
                Text("Shopping List")
                    .foregroundColor(Color("PrimaryText"))
                    .padding(.vertical)
                    .padding(.leading)
                Spacer()
            }

            Divider()
            switch viewModel.loadingState {
            case .idle, .loading:
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .listRowBackground(Color.clear)
            case .loaded:
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
            case .error:
                VStack {
                    Spacer()
                    Image(systemName: "house.lodge.fill")
                        .font(.headline)
                        .foregroundColor(.orange)
                    Text("Please add or join a home")
                        .font(.headline)
                        .foregroundColor(.orange)
                    Spacer()
                }
            }

        }
        .task {
            await viewModel.loadShoppingList()
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
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
