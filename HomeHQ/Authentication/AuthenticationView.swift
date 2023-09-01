//
//  AuthenticationView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//


// MARK: DO NOT MARK - WRITTEN PRIOR TO THIS SUBJECT

import SwiftUI

// Main authentication view with options for sign in with google
// and sign in with email
struct AuthenticationView: View {

    // Declare bool for showSignInView that will be set to false once user has signed in
    @Binding var showSignInView: Bool
    
    // Variable to store current display color scheme
    @Environment(\.colorScheme) var colorScheme

    
    @StateObject private var viewModel = AuthenticationViewModel()


    var body: some View {
        ZStack {
            Color("BackgroundPrimary")
            .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                title
                Button {
                    Task {
                        do {
                            try await viewModel.signInApple()
                            showSignInView = false
                        } catch {
                            viewModel.signInError = true
                            viewModel.errorText = "Sign in with Apple could not be completed"
                        }
                    }
                } label: {
                    appleSignInButton
                }

                // Google sign in button that calls async signInGoogle
                // function from viewModel and sets showSignInView to false
                // once completed, displays error message if not sucessful
                Button {
                    Task {
                        do {
                            try await viewModel.signInGoogle()
                            showSignInView = false
                        } catch {
                            viewModel.signInError = true
                            viewModel.errorText = "Sign in with Google could not be completed"
                        }
                    }
                } label: {
                    googleSignInButton
                }

                // Navigation link that displays email sign in view and passes
                // the bound showSignInView bool
                NavigationLink {
                    EmailSignInView(showSignInView: $showSignInView)
                } label: {
                    emailSignInButton
                }
                Spacer()

                // Alert that is displayed if google sign in fails
                    .alert(viewModel.errorText, isPresented: $viewModel.signInError) {
                    Button("Ok", role: .cancel) { }
                }
            }
        }
    }

    var googleSignInButton: some View {
        HStack {
            Image("GoogleLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18)
            Text("Sign in with Google")
        }
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding(.horizontal)
        .foregroundColor(Color("PrimaryText"))
    }

    var emailSignInButton: some View {
        HStack {
            Image(systemName: "envelope")
                .font(.headline)
                .foregroundColor(Color("PrimaryText"))
            Text("Sign in with Email")
        }
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding(.horizontal)
        .foregroundColor(Color("PrimaryText"))
    }
    
    var appleSignInButton: some View {
        SignInWithAppleButtonViewRepresentable(type: .default, style: colorScheme == .dark ? .white : .black)
            .allowsHitTesting(false)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal)
    }
    
    var title: some View {
        Image("Banner")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
            .padding()

    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }

    }
}
