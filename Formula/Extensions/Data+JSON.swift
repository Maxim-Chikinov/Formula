//
//  Data+JSON.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import Foundation

extension Data {
    var toJSON: [String : Any]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: .allowFragments)
            let json = jsonObject as? [String: Any]
            return json
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    var toArrayOfJSONs: [[String : Any]]? {
        let jsonObject = try? JSONSerialization.jsonObject(with: self, options: .allowFragments)
        let json = jsonObject as? [[String: Any]]
        return json
    }
    
    var jsonToString: String {
        return String(data: self, encoding: String.Encoding.utf8) ?? ""
    }
}
