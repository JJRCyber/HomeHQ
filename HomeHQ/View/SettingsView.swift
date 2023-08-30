//
//  SettingsView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var showSignInView: Bool
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            if let user = viewModel.user {
                Text("Account Details")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryText"))
                    .padding()
                Divider()
                HStack {
                    Text("User Name:")
                        .padding()
                    Spacer()
                    TextField("Username", text: $viewModel.userName)
                }
                Divider()
                HStack {
                    Text("Display Name:")
                        .padding()
                    Spacer()
                    TextField("Display Name", text: $viewModel.name)
                }
                Divider()
                HStack {
                    Text("Email:")
                        .padding()
                    Spacer()
                    TextField("Email", text: $viewModel.email)
                }
                Divider()
                HStack {
                    Text("Mobile:")
                        .padding()
                    Spacer()
                    TextField("Mobile", text: $viewModel.mobile)
                }
                Divider()
                .task {
                    viewModel.updateValues()

                }


            }
            Spacer()
            Button {
                try? viewModel.signOut()
                showSignInView = true
            } label: {
                Text("Sign out")
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color("ButtonBackgroundSecondary"))
                    .cornerRadius(10)
                    .padding()
                    .foregroundColor(Color("PrimaryText"))
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var viewModel: SettingsViewModel = {
        let vm = SettingsViewModel()
        vm.user = UserProfile(userId: "AAAAA", userName: "cooperj97", email: "cooperj97@gmail.com", mobile: "0430429729", name: "Cooper", birthday: Date(), dateCreated: Date())
        return vm
    }()
    
    static var previews: some View {
        SettingsView(showSignInView: .constant(false), viewModel: viewModel)
    }
}
