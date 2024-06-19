//
//  FontsList.swift
//  Formula
//
//  Created by Chikinov Maxim on 19.06.2024.
//

import SwiftUI

struct FontsListView: View {
    let allFontNames = UIFont.familyNames
        .flatMap { UIFont.fontNames(forFamilyName: $0) }
    
    var body: some View {
        List(allFontNames, id: \.self) { name in
            Text(name).font(Font.custom(name, size: 12))
        }
    }
}

#Preview {
    FontsListView()
}
