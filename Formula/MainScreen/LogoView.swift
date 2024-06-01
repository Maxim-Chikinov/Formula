//
//  LogoView.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

struct LogoView: View {
    var image = "clipboard.fill"
    
    var body: some View {
        Image(systemName: image)
            .resizable()
            .frame(width: 26, height: 26)
            .cornerRadius(10)
            .padding(18)
            .background(.ultraThinMaterial.opacity(0.4))
            .cornerRadius(18)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}

