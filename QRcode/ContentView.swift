//
//  ContentView.swift
//  QRcode
//
//  Created by Philippe MICHEL on 08/09/2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var text = "www.example.com"
    @State private var qrCodeImage: UIImage?
    @State private var isSheetPresented = false
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        VStack {
            TextField("Enter text", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                isSheetPresented = true
                qrCodeImage = generateQRCode(from: text)
                
            }) {
                Text("Générer le QR Code")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .sheet(isPresented: $isSheetPresented) {
            if let qrCodeImage = qrCodeImage {
                QRCodeSheetView(qrCodeImage: qrCodeImage)
            }
        }
    }

    func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
}

struct QRCodeSheetView: View {
    let qrCodeImage: UIImage

    var body: some View {
        VStack {
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
    ContentView()
}
