//
//  RemindersWidgetView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct RemindersWidgetView: View {
    var body: some View {
        HStack(spacing: 20) {
            VStack() {
                Text("Reminders")
                    .font(.headline)
                    .padding(.top)
                Spacer()
            }
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            .background(Color("Highlight"))
            .cornerRadius(10)
            .padding(.leading)
            .foregroundColor(Color("SecondaryText"))
        }
        

        
    }
}

struct RemindersWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersWidgetView()
    }
}
