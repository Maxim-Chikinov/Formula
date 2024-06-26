//
//  APIErrors.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import Foundation

enum APIErrors: Int, LocalizedError {
    case badRequest = 400
    case unAuthorized = 401
    case tooManyRequests = 429
    case serverError = 500
    
    var errorDescription: String? {
        switch self {
        case .tooManyRequests:
            return "You made too many requests within a window of time and have been rate limited. Back off for a while.".localized()
        case .serverError:
            return "Server error.".localized()
        default:
            return "Something goes wrong.".localized()
        }
    }
}

