//
//  EndpointProtocol.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import Foundation

protocol EndpointProtocol {
    var locale: String { get }
    
    var region: String { get }
    
    var baseURL: String { get }
    
    var absoluteURL: String { get }
    
    var params: [String: String] { get }
    
    var headers: [String: String] { get }
}

extension EndpointProtocol {
    var locale: String {
        return Locale.current.languageCode ?? "en"
    }
    
    var region: String {
        return Locale.current.regionCode ?? "us"
    }
}
