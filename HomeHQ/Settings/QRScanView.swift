//
//  QRScanView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 11/9/2023.
//

import SwiftUI
import CodeScanner

struct QRScanView: View {
    let completion: (Result<ScanResult, ScanError>) -> Void
    var body: some View {
        ZStack {
            Color("BackgroundPrimary")
            VStack {
                Text("Scan a QR Code")
                    .font(.headline)
                    .foregroundColor(Color("PrimaryText"))
                    .padding()
                CodeScannerView(codeTypes: [.qr], completion: completion)
            }
        }


    }
}

struct QRScanView_Previews: PreviewProvider {
    static var previews: some View {
        QRScanView { result in
            print("hello")
        }
    }
}
