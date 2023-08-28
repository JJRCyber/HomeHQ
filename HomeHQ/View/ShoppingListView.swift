//
//  ShoppingListView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 27/8/2023.
//

import SwiftUI

struct ShoppingListView: View {
    
    @StateObject var viewModel = ShoppingListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                Spacer()
                Text("Shopping List")
                    .foregroundColor(Color("PrimaryText"))
                    .padding(.vertical)
                    .padding(.leading)
                Spacer()
                Image(systemName: "plus")
                    .padding(.trailing)
            }

            Divider()
            if !viewModel.shoppingList.isEmpty {
                List {
                    TextField("Add Item", text: $viewModel.newItemName)
                        .listRowBackground(Color.clear)
                        .foregroundColor(Color("PrimaryText"))
                        .font(.callout)
                        .onSubmit {
                            viewModel.addItem()
                        }
                    ForEach(viewModel.shoppingList) { item in
                        ShoppingListRowView(item: item)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    viewModel.updateItemCompletion(item: item)
                                }
                            }
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }
                .listStyle(.plain)
            } else {
                Spacer()
                Text("Nothing in Shopping List!")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryText"))
                Spacer()
            }

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
