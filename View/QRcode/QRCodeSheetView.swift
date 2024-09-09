//
//  QRCodeSheetView.swift
//  QRcode
//
//  Created by Philippe MICHEL on 09/09/2024.
//

import SwiftUI

struct QRCodeSheetView: View {
    let qrCodeImage: UIImage // image du qrcode

    var body: some View {
        VStack {
            // dimenssion du qrcode
            Image(uiImage: qrCodeImage)
                .interpolation(.none)
                .resizable()
                .frame(width: 200, height: 200)
                .padding()

            Spacer()
        }
        .presentationDetents([.medium]) // Affiche la feuille à demi-hauteur
    }
}

#Preview {
    QRCodeSheetView(qrCodeImage: UIImage(named: "qrcode")!)
}
