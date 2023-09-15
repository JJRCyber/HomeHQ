//
//  ShoppingListRowView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 27/8/2023.
//

import SwiftUI

// Custom list view for each shopping list item
struct ShoppingListRowView: View {
    
    // Has the parent viewModel passed in
    @ObservedObject var viewModel: ShoppingListViewModel
    let item: ShoppingListItem
    
    //MARK: View
    // Fairly complicated view as it contains multiple points of interaction
    var body: some View {
        HStack(spacing: 0) {
            Text(item.name)
                .font(.callout)
                .foregroundColor(Color("PrimaryText"))
                .padding()
            Spacer()
            quantityStepper
            // Checkbox becomes filled and turns green when pressed
            Image(systemName: item.completed ? "checkmark.circle.fill": "circle")
                .foregroundColor(item.completed ? .green: Color("PrimaryText"))
                .padding()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        // Updates the item completion property
                        viewModel.updateItemCompletion(item: item)
                    }
                }
        }
        // Green overlay the moves from left to right with animation
        // This is to provide user feedback the item is completed and will be removed
        .contentShape(Rectangle())
        .overlay(
            HStack {
                Color.green
                    .opacity(0.3)
                    .frame(maxWidth: item.completed ? .infinity : 0)
                Spacer()
            }
            // Prevents overlay from being tapped so user can "undo" the completion
            .allowsHitTesting(false)
        )
        .frame(maxWidth: .infinity)
    }
    
    //MARK: View Components
    // Custom stepper to increase and decrease quantity
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
    
    // Plus button to increase quantity
    var plusButton: some View {
        Image(systemName: "plus.circle.fill")
            .foregroundColor(Color("ButtonBackgroundSecondary"))
            .onTapGesture {
                viewModel.updateItemQuantity(item: item, newQuantity: item.quantity + 1)
            }
    }
    
    // Minus button to decrease quantity
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
