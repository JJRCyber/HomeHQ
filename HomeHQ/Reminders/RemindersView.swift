//
//  RemindersView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct RemindersView: View {

    @StateObject var viewModel = RemindersViewModel()


    var body: some View {
        ZStack {
            Color("BackgroundPrimary")
            VStack(spacing: 0) {
                ShoppingListView()
                Spacer()
            }
        }
    }

}

struct RemindersView_Previews: PreviewProvider {
    static var viewModel: TabBarViewModel = {
        let vm = TabBarViewModel()
        vm.selectedTab = 3
        return vm
    }()
    
    static var previews: some View {
        TabBarView(showSignInView: .constant(false), tabBarViewModel: viewModel)
    }
}
