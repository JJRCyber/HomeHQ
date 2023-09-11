//
//  AddMemberView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 11/9/2023.
//

import SwiftUI

struct AddMemberView: View {
    
    @ObservedObject var viewModel: HomeProfileViewModel
    let homeId: String
    
    var body: some View {
        ZStack {
            Color("ButtonBackground")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Scan to join this home!")
                    .font(.subheadline)
                    .foregroundColor(Color("PrimaryText"))
                    .padding()
                    .padding(.horizontal)
                Image(uiImage: viewModel.generateQRCode(homeId: homeId))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("Or enter this code: \(homeId)")
                    .font(.subheadline)
                    .foregroundColor(Color("PrimaryText"))
                    .padding()
                    .padding(.horizontal)
            }
        }

    }
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView(viewModel: HomeProfileViewModel(), homeId: "xxxxx")
    }
}
