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

                List {
                    Section(header: Text("User Details")) {
                        Text("User ID: \(user.userId)")
                        VStack(alignment: .leading) {
                            Text("Username")
                                .font(.caption)
                            TextField("Enter your username", text: $viewModel.userName)
                        }
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.caption)
                            TextField("Enter your name", text: $viewModel.name)
                        }
                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.caption)
                            TextField("Enter your email", text: $viewModel.email)
                        }
                        VStack(alignment: .leading) {
                            Text("Mobile")
                                .font(.caption)
                            TextField("Enter your email", text: $viewModel.mobile)
                        }
                    }
                    Section(header: Text("House Details")) {
                        if let homeId = user.homeId {
                            Text("\(homeId)")
                        } else {
                            Button {
                                viewModel.createHome()
                            } label: {
                                Text("Create a Home")
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color("PrimaryText"))
                                    .background(Color("Highlight"))
                                    .cornerRadius(10)
                            }
                            .listRowBackground(Color.clear)
                        }
                    }

                    
                }
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
