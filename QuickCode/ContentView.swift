//
//  ContentView.swift
//  QuickCode
//
//  Created by Alexis Akers on 3/11/21.
//

import SwiftUI
import AVFoundation
import RSBarcodes_Swift

enum BarcodeType: String, CaseIterable, Identifiable {
    case code128
    case ean8
    case ean13
    case upc

    var id: BarcodeType { self }

    var rawCodeType: AVMetadataObject.ObjectType {
        switch self {
        case .code128:
            return .code128
        case .upc:
            return .upce
        case .ean8:
            return .ean8
        case .ean13:
            return .ean13
        }
    }
}

struct ContentView: View {
    @State private var selectedBarcodeType = BarcodeType.ean8
    @State private var input: String = ""
    @State private var image: Image?

    var isInputValid: Bool {
        guard !input.isEmpty else {
            return false
        }

        for scalar in input.unicodeScalars {
            if !CharacterSet.decimalDigits.contains(scalar) {
                return false
            }
        }

        return true
    }

    var body: some View {
        VStack {
            HStack {
                Text("QuickCode")
                    .font(.headline)
                Spacer()
            }

            Picker(
                selection: $selectedBarcodeType,
                label: Text("Code Type"),
                content: {
                    ForEach(BarcodeType.allCases) {
                        Text($0.rawValue)
                    }
                }
            )

            TextField("Code", text: $input)

            Button("Generate", action: generateImage)
                .disabled(!isInputValid)

            image?
                .padding(.top, 16)
        }
        .padding(16)
    }

    private func generateImage() {
        let imageSize = CGSize(width: 200, height: 100)
        let baseImage = RSUnifiedCodeGenerator.shared.generateCode(input, inputCorrectionLevel: .Medium, machineReadableCodeObjectType: selectedBarcodeType.rawCodeType.rawValue, ignoreValidation: true, targetSize: imageSize)
        self.image = baseImage.map(Image.init(nsImage:))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
