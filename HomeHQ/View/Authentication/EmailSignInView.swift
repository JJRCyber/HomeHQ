//
//  EmailSignInView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//


// MARK: DO NOT MARK - WRITTEN PRIOR TO THIS SUBJECT

import SwiftUI

struct EmailSignInView: View {

    // Binding for showSignInView that will be set to false once user is logged in
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = EmailSignInViewModel()


    var body: some View {
        ZStack {
            Color("BackgroundPrimary")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Image("Banner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .padding()
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryText"))
                TextField("Email...", text: $viewModel.email)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("ButtonBackground"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                SecureField("Password...", text: $viewModel.password)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("ButtonBackground"))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // When button is pressed call signIn function and display any errors
                // with alert popup
                Button {
                    Task {
                        do {
                            try await viewModel.signIn(email: viewModel.email, password: viewModel.password)
                            showSignInView = false
                        } catch let error as SignInErrors {
                            // Basic input validation issues raise custom error
                            viewModel.signUpError = true
                            viewModel.errorMessage = error.localizedDescription
                        } catch {
                            // Displays any errors thrown by Firebase
                            viewModel.signUpError = true
                            viewModel.errorMessage = error.localizedDescription
                        }
                    }
                } label: {
                    Text("Sign In With Email")
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color("Highlight"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(Color("PrimaryText"))
                }
                Button {
                    viewModel.showForgotPasswordView = true
                } label: {
                    Text("Forgot Password?")
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color("ButtonBackgroundSecondary"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(Color("PrimaryText"))
                }

                NavigationLink {
                    EmailSignUpView(showSignInView: $showSignInView)
                } label: {
                    Text("Don't have an account?")
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color("ButtonBackgroundSecondary"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(Color("PrimaryText"))
                }
                Spacer()
                // Alert that displays error message localizedDescription and has button to dismiess
                    .alert(viewModel.errorMessage, isPresented: $viewModel.signUpError) {
                    Button("Ok", role: .cancel) { }
                }
            }
        }
        .sheet(isPresented: $viewModel.showForgotPasswordView) {
            ForgotPasswordView(viewModel: viewModel)
        }
    }
}

struct EmailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EmailSignInView(showSignInView: .constant(false))
        }
    }
}
