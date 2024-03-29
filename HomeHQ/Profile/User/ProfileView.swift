//
//  SettingsView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct ProfileView: View {
    
    // Bound to showSignInView so user is returned to sign in screen when they log out
    @Binding var showSignInView: Bool
    @StateObject var viewModel = ProfileViewModel()
    
    //MARK: View
    var body: some View {
        ZStack {
            Color("ButtonBackground")
                .edgesIgnoringSafeArea(.all)
            
            // Switch presented view based on loadingState
            switch viewModel.loadingState {
            case .idle, .loading:
                LoadingView()
            case .loaded:
                VStack {
                    if let user = viewModel.user {
                        List {
                            Section(header: Text("Account Details")) {
                                Text("User ID: \(user.userId)")
                                Text("Email: \(user.email ?? "")")
                            }
                            .listRowBackground(Color.clear)
                            
                            // Allows updating of username, name and mobile
                            Section(header: Text("User Profile")) {
                                userNameTextField
                                nameTextField
                                mobileTextField
                            }
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(.plain)
                        
                        updateProfileButton
                        Spacer()
                    }
                    Spacer()
                    
                    // Try to signout then set binding showSignInView to true
                    // This returns app back to login screen
                    // Error is ignored as it does not matter if sign out fails
                    // User will be returned to sign in screen regardless
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
                // Disables keyboard avoidance
                .ignoresSafeArea(.keyboard)
                
                // Displays alert popup if any functions throw erros
                .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                    Button("Ok", role: .cancel) { }
                }
            case .error:
                MissingHomeView()
            }
            
            
        }
        // Async task to load current user from Firestore
        .task {
            await viewModel.loadData()
        }
        .navigationTitle("User Profile")
    }
    
    //MARK: View Components
    // Variable below are basic view components
    var userNameTextField: some View {
        VStack(alignment: .leading) {
            Text("Username")
                .font(.caption)
            TextField("Enter your username", text: $viewModel.userName)
        }
    }
    
    var nameTextField: some View {
        VStack(alignment: .leading) {
            Text("Name")
                .font(.caption)
            TextField("Enter your name", text: $viewModel.name)
        }
    }
    
    var mobileTextField: some View {
        VStack(alignment: .leading) {
            Text("Mobile")
                .font(.caption)
            TextField("Enter your mobile", text: $viewModel.mobile)
        }
    }
    
    var updateProfileButton: some View {
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
