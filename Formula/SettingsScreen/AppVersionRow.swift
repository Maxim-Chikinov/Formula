//
//  AppVersionRow.swift
//  Formula
//
//  Created by Chikinov Maxim on 02.06.2024.
//

import SwiftUI

struct AppVersionRow: View {
    var imageName: String
    var title: String
    var version: String
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .font(.headline)
                .foregroundColor(.purple)
                .frame(minWidth: 25, alignment: .leading)
                .accessibility(hidden: true)

            Text(title)
            Spacer()
            Text(version)
                .bold()
        }
        .accessibilityElement(children: .combine)
        .padding(.vertical, 10)
        .foregroundColor(.primary)
    }
}

struct AppVersionRow_Previews: PreviewProvider {
    static var previews: some View {
        AppVersionRow(imageName: "info.circle", title: "App version", version: "2.0")
    }
}

