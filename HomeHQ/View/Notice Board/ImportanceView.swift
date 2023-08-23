//
//  ImportanceView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 23/8/2023.
//

import SwiftUI

struct ImportanceView: View {
    
    let importance: Int
    var body: some View {
        HStack(spacing: 5) {
            Capsule()
                .frame(width: 10, height: 5)
                .foregroundColor((importance < 1) ? Color.gray : Color.green)
            Capsule()
                .frame(width: 10, height: 5)
                .foregroundColor((importance < 2) ? Color.gray : Color.yellow)
            Capsule()
                .frame(width: 10, height: 5)
                .foregroundColor((importance < 3) ? Color.gray : Color.orange)
            Capsule()
                .frame(width: 10, height: 5)
                .foregroundColor((importance < 4) ? Color.gray : Color.red)
        }
    }
}

struct ImportanceView_Previews: PreviewProvider {
    static var previews: some View {
        ImportanceView(importance: 4)
    }
}
