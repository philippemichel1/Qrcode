//
//  ContentView.swift
//  QRcode
//
//  Created by Philippe MICHEL on 08/09/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var inputText: String = ""
    @FocusState private var focus:Bool
    @State private var qrCodeImage: UIImage?

    var body: some View {
        VStack {
            Text("Générer votre QRCODE")
                .frame(width:380, height:50)
                .bold()
                .font(.title)
                .background(.red)
                .cornerRadius(25)
            
                
            TextField("Entrez le texte pour le QRCode", text: $inputText)
                .onAppear() {
                    focus = true
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of:inputText) {
                    qrCodeImage = nil
                    focus = true
                }
            
                
                

            Button(action: generateQRCode) {
                Text("Générer QRCode")
            }
            .padding()
            .buttonStyle(.bordered)
            
            if let qrCodeImage = qrCodeImage {
                Image(uiImage: qrCodeImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .padding()
    }
// fonction de génération du qrcode
    func generateQRCode() {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(inputText.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                qrCodeImage = UIImage(cgImage: cgImage)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
