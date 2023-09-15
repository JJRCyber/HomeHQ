//
//  QRScanView.swift
//  HomeHQ
//
//  Created by Cooper Jacob on 11/9/2023.
//

import SwiftUI
import CodeScanner

// QR Scan view using an external library that launches camera and will close view once QR code scanned
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
                // Displays code scanner view - this does not work on simulator due to no camera access so it just returns
                // the simulated data. This will join the demo home but in real world would return whatever homeId the QR contains
                CodeScannerView(codeTypes: [.qr], simulatedData: "98FABB8E-CDB9-4D6C-B145-E79C75DD042D", completion: completion)
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
