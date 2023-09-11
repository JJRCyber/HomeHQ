//
//  SettingsView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var showSignInView: Bool
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            Color("ButtonBackground")
                .edgesIgnoringSafeArea(.all)
            VStack {
                if let user = viewModel.user {
                    List {
                        Section(header: Text("Account Details")) {
                            Text("User ID: \(user.userId)")
                            Text("Email: \(user.email ?? "")")
                        }
                        Section(header: Text("User Profile")) {
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
                                Text("Mobile")
                                    .font(.caption)
                                TextField("Enter your mobile", text: $viewModel.mobile)
                            }
                        }
                        
                    }
                    Button {
                        viewModel.updateUserProfile()
                    } label: {
                        Text("Update Profile")
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color("Highlight"))
                            .cornerRadius(10)
                            .padding()
                            .foregroundColor(Color("PrimaryText"))
                    }
                    Spacer()
                    
                    .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                        Button("Ok", role: .cancel) { }
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
        .navigationTitle("User Profile")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var viewModel: ProfileViewModel = {
        let vm = ProfileViewModel()
        vm.user = UserProfile(userId: "AAAAA", userName: "cooperj97", email: "cooperj97@gmail.com", mobile: "0430429729", name: "Cooper", birthday: Date(), dateCreated: Date())
        return vm
    }()
    
    static var previews: some View {
        NavigationStack {
            ProfileView(showSignInView: .constant(false), viewModel: viewModel)
        }
    }
}
