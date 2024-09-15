//
//  ContentView.swift
//  QRcode
//
//  Created by Philippe MICHEL on 08/09/2024.
//
import SwiftUI
//importe les initialisateurs de filtres type-safe.
import CoreImage.CIFilterBuiltins

// Déclaration de la structure ContentView qui est une vue dans SwiftUI
struct ContentView: View {
    // Déclaration d'une variable d'état pour stocker le texte du QR Code
    @State private var textQrCode: String = ""
    // Déclaration d'une variable d'état pour gérer le focus sur le champ de texte
    @FocusState private var focus: Bool
    // Déclaration d'une variable d'état pour stocker l'image générée du QR Code
    @State private var qrCodeImage: UIImage?
    
    // Corps de la vue
    var body: some View {
            VStack {
                // Titre de l'application
                Text("Générer votre QRCODE")
                    .frame(width: 380, height: 50) // Définition de la taille du cadre
                    .bold() // Texte en gras
                    .font(.title) // Taille de police de titre
                    .background(.red) // Couleur de fond rouge
                    .cornerRadius(25) // Coins arrondis
                Spacer() // Espace flexible pour séparer les éléments
                
                // Champ de texte pour entrer le texte du QR Code
                TextField("Entrez le texte pour le QRCode", text: $textQrCode)
                    .font(.title2)
                    .onAppear() {
                        focus = true // Met le champ de texte en focus à l'apparition
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // Style de bordure arrondie
                    .padding() // Ajoute du padding autour du champ de texte
                    .onChange(of: textQrCode) {
                        qrCodeImage = nil // Réinitialise l'image du QR Code
                        focus = true // Garde le focus sur le champ de texte
                    }
                
                // Affiche l'image du QR Code si elle est générée
                if let qrCodeImage = qrCodeImage {
                    Image(uiImage: qrCodeImage)
                        .interpolation(.none) // Pas d'interpolation pour une image nette
                        .resizable() // Rend l'image redimensionnable
                        .scaledToFit() // Adapte l'image à la taille du cadre
                        .frame(width: 200, height: 200) // Taille du cadre de l'image
                }
                
                // Bouton pour générer le QR Code
                Button {
                    withAnimation {
                        QrCodeGenerate()
                    }
                } label: {
                    Text("Générer QRCode") // Texte du bouton
                }
                .padding() // Ajoute du padding autour du bouton
                .buttonStyle(.bordered) // Style de bouton avec bordure
                Spacer() // Espace flexible pour séparer les éléments
            }
            .padding() // Ajoute du padding autour de la pile verticale
        }
        
        // Fonction pour générer le QR Code
        func QrCodeGenerate() {
            let context = CIContext() // Crée un contexte Core Image
            let filter = CIFilter.qrCodeGenerator() // Crée un filtre générateur de QR Code
            let data = Data(textQrCode.utf8) // Convertit le texte en données UTF-8
            filter.setValue(data, forKey: "inputMessage") // Définit le message du QR Code
            
            // Génère l'image du QR Code
            if let outputImage = filter.outputImage {
                if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                    qrCodeImage = UIImage(cgImage: cgImage) // Convertit l'image en UIImage
                }
            }
        }
}

#Preview {
    ContentView()
}
