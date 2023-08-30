//
//  ShoppingListWidgetRowView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import SwiftUI

struct ShoppingListWidgetRowView: View {
    
    @ObservedObject var viewModel: ShoppingListViewModel
    let item: ShoppingListItem
    
    var body: some View {
        HStack(spacing: 0) {
            Text(item.name)
                .font(.caption)
                .foregroundColor(Color("PrimaryText"))
                .padding(.horizontal)
            Spacer()
            quantityIndicator
            Image(systemName: item.completed ? "checkmark.circle.fill": "circle")
                .font(.caption)
                .foregroundColor(item.completed ? .green: Color("PrimaryText"))
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation(.linear) {
                        viewModel.updateItemCompletion(item: item)
                    }
                }
        }
        .frame(maxWidth: .infinity)
    }
    
    var quantityIndicator: some View {
        HStack {
            Spacer()
            Text("\(item.quantity)")
                .font(.caption)
                .foregroundColor(Color("PrimaryText"))
        }
        .frame(width: 40)
    }
}

struct ShoppingListWidgetRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListWidgetRowView(viewModel: ShoppingListViewModel(), item: ShoppingListItem(name: "Banana", quantity: 10, completed: false))
    }
}
