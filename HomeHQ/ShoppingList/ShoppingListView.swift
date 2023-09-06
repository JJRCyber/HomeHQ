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
        .task {
            try? await viewModel.loadHome()
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
