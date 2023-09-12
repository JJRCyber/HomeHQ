//
//  MissingHomeView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 11/9/2023.
//

import SwiftUI

// Error view that is displayed when a home cannot be loaded
struct MissingHomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "house.lodge.fill")
                .font(.headline)
                .foregroundColor(.orange)
            Text("Please add or join a home")
                .font(.subheadline)
                .foregroundColor(.orange)
            Spacer()
        }
    }
}

struct MissingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MissingHomeView()
    }
}
