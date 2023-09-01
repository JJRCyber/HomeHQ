//
//  ShoppingListWidgetView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import SwiftUI

struct ShoppingListWidgetView: View {
    
    @StateObject var viewModel = ShoppingListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Shopping List")
                .foregroundColor(Color("PrimaryText"))
                .font(.caption)
                .padding(.vertical, 8)
            Divider()
            ScrollView {
                Spacer()
                ForEach(viewModel.shoppingList) { item in
                    ShoppingListWidgetRowView(viewModel: viewModel, item: item)
                    Divider()
                }
            }

            Spacer()
        }
        .frame(maxHeight: 150)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding(.trailing)
    }
}

struct ShoppingListWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListWidgetView()
    }
}
