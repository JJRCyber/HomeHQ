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
                    withAnimation(.easeInOut(duration: 2.0)) {
                        viewModel.updateItemCompletion(item: item)
                    }
                }
        }
        .contentShape(Rectangle())  // This allows the HStack to respond to tap events
        .overlay(
            HStack {
                Color.green
                    .opacity(0.3)
                    .frame(maxWidth: item.completed ? .infinity : 0)
                Spacer()
            }
            .allowsHitTesting(false) // This disables taps for the overlay
        )
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
            .foregroundColor(Color("ButtonBackgroundSecondary"))
            .onTapGesture {
                viewModel.updateItemQuantity(item: item, newQuantity: item.quantity + 1)
            }
    }
    
    var minusButton: some View {
        Image(systemName: "minus.circle.fill")
            .foregroundColor(Color("ButtonBackgroundSecondary"))
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
