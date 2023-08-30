//
//  ForgotPasswordView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 30/8/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var viewModel: EmailSignInViewModel
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color("BackgroundColor"), Color("BackgroundColorSecondary")], center: .topLeading, startRadius: 5, endRadius: 500).ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button {
                        viewModel.showForgotPasswordView = false
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("PrimaryText"))
                            .font(.title)
                    }
                    .padding()

                }
                Image("BannerHorizontal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .padding()
                Text("Please enter your account email address to be sent a password reset email")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("PrimaryText"))
                    .font(.subheadline)
                TextField("Email...", text: $viewModel.email)
                
                Button {
                    Task {
                        do {
                            try await AuthenticationManager.shared.resetPassword(email: viewModel.email)
                            viewModel.passwordResetSuccess = true
                        } catch {
                            viewModel.passwordResetError = true
                            viewModel.passwordResetErrorMessage = error.localizedDescription
                        }
                    }
                } label: {
                    Text("Send Password Reset Email")
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color("ButtonBackground"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(Color("PrimaryText"))
                }
                .alert("Password reset email sent!", isPresented: $viewModel.passwordResetSuccess) {
                    Button("Ok", role: .cancel) {
                        viewModel.showForgotPasswordView = false
                    }
                }
                Spacer()
            }
            .alert(viewModel.passwordResetErrorMessage, isPresented: $viewModel.passwordResetError) {
            Button("Ok", role: .cancel) { }
        }

        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(viewModel: EmailSignInViewModel())
    }
}
