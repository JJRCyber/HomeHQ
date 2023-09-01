//
//  ShoppingListRowView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 27/8/2023.
//

import SwiftUI

struct ShoppingListRowView: View {
    
    @ObservedObject var viewModel: ShoppingListViewModel
    let item: ShoppingListItem
    
    var body: some View {
        HStack(spacing: 0) {
            Text(item.name)
                .font(.callout)
                .foregroundColor(Color("PrimaryText"))
                .padding()
            Spacer()
            quantityStepper
            Image(systemName: item.completed ? "checkmark.circle.fill": "circle")
                .foregroundColor(item.completed ? .green: Color("PrimaryText"))
                .padding()
                .onTapGesture {
                    withAnimation(.linear) {
                        viewModel.updateItemCompletion(item: item)
                    }
                }
        }
        .frame(maxWidth: .infinity)
    }
    
    var quantityStepper: some View {
        HStack {
            Spacer()
            minusButton
            Text("\(item.quantity)")
                    .font(.callout)
                    .foregroundColor(Color("PrimaryText"))
                    .frame(width: 20)
            plusButton
            Spacer()
        }
        .frame(width: 80)
    }
    
    var plusButton: some View {
        Image(systemName: "plus.circle.fill")
            .foregroundColor(.green)
            .onTapGesture {
                viewModel.updateItemQuantity(item: item, newQuantity: item.quantity + 1)
            }
    }
    
    var minusButton: some View {
        Image(systemName: "minus.circle.fill")
            .foregroundColor(.red)
            .onTapGesture {
                viewModel.updateItemQuantity(item: item, newQuantity: item.quantity - 1)
            }
    }
}

struct ShoppingListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListRowView(viewModel: ShoppingListViewModel(), item: ShoppingListItem(name: "Banana", quantity: 10, completed: false))
    }
}
