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
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSignInView: .constant(false))
    }
}
