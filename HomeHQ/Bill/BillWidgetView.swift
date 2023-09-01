//
//  BillWidgetView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct BillWidgetView: View {
    
    
    var body: some View {
        HStack(alignment: .top) {
            Text("Upcoming Bills")
                .font(.headline)
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding(.horizontal)
        .foregroundColor(Color("PrimaryText"))
    }
}

struct BillWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        BillWidgetView()
    }
}
