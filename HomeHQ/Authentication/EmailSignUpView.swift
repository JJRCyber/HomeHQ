//
//  EmailSignUpView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//


// MARK: DO NOT MARK - WRITTEN PRIOR TO THIS SUBJECT

import SwiftUI

struct EmailSignUpView: View {

    // Binding for showSignInView that will be set to false once user is logged in
    @Binding var showSignInView: Bool



    @StateObject private var viewModel = EmailSignUpViewModel()

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
                Text("Sign Up With Email")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryText"))
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("ButtonBackground"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .overlay(
                        Group(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .padding(.horizontal)
                            .foregroundColor(.red)
                        Text("Invalid Email")
                            .font(.caption)
                            .foregroundColor(.red)
                            .offset(y: 35)
                    })
                                .opacity(viewModel.isValidEmail(email: viewModel.email) ? 0 : 100)
                    )
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("ButtonBackground"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .textContentType(.newPassword)
                    .textInputAutocapitalization(.never)
                    .overlay(
                        Group(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .padding(.horizontal)
                            .foregroundColor(.red)
                        Text("Invalid Password")
                            .font(.caption)
                            .foregroundColor(.red)
                            .offset(y: 35)
                    })
                                .opacity(viewModel.isValidPassword(password: viewModel.password) ? 0 : 100)
                        
                    )
                SecureField("Re-enter Password", text: $viewModel.passwordCheck)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("ButtonBackground"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .overlay(
                        Group(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .padding(.horizontal)
                            .foregroundColor(.red)
                        Text("Passwords do not match")
                            .font(.caption)
                            .foregroundColor(.red)
                            .offset(y: 35)
                    })
                        .opacity(viewModel.passwordsMatch(password: viewModel.password, passwordCheck: viewModel.passwordCheck) ? 0 : 100)
                        
                    )

                // When button is pressed call signUp function and display any errors
                // with alert popup
                Button {
                    Task {
                        do {
                            try await viewModel.signUp(email: viewModel.email, password: viewModel.password, passwordCheck: viewModel.passwordCheck)
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
                    Text("Sign Up")
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color("Highlight"))
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
    }
}

struct EmailSignUp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EmailSignUpView(showSignInView: .constant(false))
        }
    }
}
