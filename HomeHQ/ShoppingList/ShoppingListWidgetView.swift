//
//  ShoppingListWidgetView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import SwiftUI

// The view for the shopping list widget displayed on dashboard
struct ShoppingListWidgetView: View {
    
    @StateObject var viewModel = ShoppingListWidgetViewModel()
    
    // Displays header and then loops over all items in shopping list 
    var body: some View {
        VStack(spacing: 0) {
            Text("Shopping List")
                .foregroundColor(Color("PrimaryText"))
                .font(.caption)
                .padding(.vertical, 8)
            Divider()
            
            // Swich based on loading state
            switch viewModel.loadingState {
            case .idle, .loading:
                loadingView
            case .loaded:
                // Uses ScrollView rather than list as list adds too much padding
                ScrollView {
                    Spacer()
                    ForEach(viewModel.shoppingList) { item in
                        ShoppingListWidgetRowView(viewModel: viewModel, item: item)
                        Divider()
                    }
                }
                Spacer()
            case .error:
                errorView
            }

        }
        .task {
            await viewModel.loadShoppingList()
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
            Button("Ok", role: .cancel) { }
        }
        .frame(maxHeight: 150)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding(.trailing)
    }
    
    // Displays a loading spinner
    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
    // Error displayed if no homeId connected to user
    // Prompts user to add or join home
    var errorView: some View {
        VStack {
            Spacer()
            Image(systemName: "house.lodge.fill")
                .font(.subheadline)
                .foregroundColor(.orange)
            Text("Please add or join a home")
                .font(.subheadline)
                .foregroundColor(.orange)
            Spacer()
        }
    }
}

struct ShoppingListWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListWidgetView()
    }
}
