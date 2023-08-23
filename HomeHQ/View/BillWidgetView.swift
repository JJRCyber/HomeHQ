//
//  BillWidgetView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct BillWidgetView: View {
    
    @StateObject var viewModel = BillViewModel()
    
    var body: some View {
        HStack(alignment: .top) {
            Text("Upcoming Bills")
                .font(.headline)
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .shadow(color: Color("AccentColor"), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
        .foregroundColor(Color("PrimaryText"))
    }
}

struct BillWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        BillWidgetView()
    }
}
