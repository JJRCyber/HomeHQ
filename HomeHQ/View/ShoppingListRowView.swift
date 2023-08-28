//
//  ShoppingListRowView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 27/8/2023.
//

import SwiftUI

struct ShoppingListRowView: View {
    
    var item: ShoppingListItem
    
    var body: some View {
        HStack(spacing: 0) {
            Text(item.name)
                .font(.callout)
                .foregroundColor(Color("PrimaryText"))
                .padding()
            Text("\(item.quantity)")
                    .font(.callout)
                    .foregroundColor(Color("PrimaryText"))
            Spacer()
            Image(systemName: item.completed ? "checkmark.circle.fill": "circle")
                .foregroundColor(item.completed ? .green: Color("PrimaryText"))
                .padding()
        }
        .frame(maxWidth: .infinity)
    }
}

struct ShoppingListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListRowView(item: ShoppingListItem(name: "Banana", quantity: 3, completed: false))
    }
}
