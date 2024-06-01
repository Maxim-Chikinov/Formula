//
//  APIProviderErrors.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import Foundation

enum APIProviderErrors: LocalizedError {
    case invalidURL
    case dataNil
    case decodingError
    case unknownError
    case badStatusCode
    
    var errorDescription: String? {
        switch self {
        case .dataNil:
            return "Empty data.".localized()
        case .decodingError:
            return "Data has invalid format.".localized()
        default:
            return "Something goes wrong.".localized()
        }
    }
}
