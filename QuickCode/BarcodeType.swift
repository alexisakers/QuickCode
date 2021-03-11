//
//  BarcodeType.swift
//  QuickCode
//
//  Created by Alexis Akers on 3/11/21.
//

import AVFoundation
import Foundation
import RSBarcodes_Swift

enum BarcodeType: String, CaseIterable, Identifiable {
    case code128
    case code39
    case code39Mod43
    case code93
    case ean8
    case ean13
    case interleaved2of5
    case isbn13
    case issn13
    case itf14
    case qr
    case upc

    var id: BarcodeType { self }

    var needsValidation: Bool {
        switch self {
        case .qr:
            return false
        default:
            return true
        }
    }

    var rawCodeType: String {
        switch self {
        case .code128:
            return AVMetadataObject.ObjectType.code128.rawValue
        case .code39:
            return AVMetadataObject.ObjectType.code39.rawValue
        case .code39Mod43:
            return AVMetadataObject.ObjectType.code39Mod43.rawValue
        case .code93:
            return AVMetadataObject.ObjectType.code93.rawValue
        case .ean8:
            return AVMetadataObject.ObjectType.ean8.rawValue
        case .ean13:
            return AVMetadataObject.ObjectType.ean13.rawValue
        case .interleaved2of5:
            return AVMetadataObject.ObjectType.interleaved2of5.rawValue
        case .isbn13:
            return RSBarcodesTypeISBN13Code
        case .issn13:
            return RSBarcodesTypeISSN13Code
        case .itf14:
            return AVMetadataObject.ObjectType.itf14.rawValue
        case .qr:
            return AVMetadataObject.ObjectType.qr.rawValue
        case .upc:
            return AVMetadataObject.ObjectType.upce.rawValue
        }
    }
}

