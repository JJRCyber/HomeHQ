//
//  HouseDutiesWidgetView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

// View not implemented
struct HouseDutiesWidgetView: View {
    var body: some View {
        HStack(alignment: .top) {
            Text("Today's Tasks")
                .font(.headline)
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .background(Color("ButtonBackground"))
        .cornerRadius(10)
        .padding(.horizontal)
        .foregroundColor(Color("PrimaryText"))
    }
}

struct HouseDutiesWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        HouseDutiesWidgetView()
    }
}
