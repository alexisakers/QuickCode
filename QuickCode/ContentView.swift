//
//  ContentView.swift
//  QuickCode
//
//  Created by Alexis Akers on 3/11/21.
//

import AVFoundation
import RSBarcodes_Swift
import SwiftUI

struct ContentView: View {
    @State private var selectedBarcodeType: BarcodeType = .code128
    @State private var input: String = ""
    @State private var image: Image?

    var isInputValid: Bool {
        guard selectedBarcodeType.needsValidation else {
            return true
        }

        return RSUnifiedCodeValidator.shared.isValid(
            input,
            machineReadableCodeObjectType: selectedBarcodeType.rawCodeType
        )
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

    // MARK: - Helpers

    private func generateImage() {
        let imageSize = CGSize(width: 200, height: 100)
        let baseImage = RSUnifiedCodeGenerator.shared.generateCode(
            input,
            inputCorrectionLevel: .Medium,
            machineReadableCodeObjectType: selectedBarcodeType.rawCodeType,
            targetSize: imageSize
        )

        self.image = baseImage.map(Image.init(nsImage:))
    }
}
