//
//  TabbarItem.swift
//  Formula
//
//  Created by Chikinov Maxim on 31.05.2024.
//

import SwiftUI

struct TabbarItem: View {
    var name: String
    var isActive: Bool = false
    let namespace: Namespace.ID

    var body: some View {
        if isActive {
            Text(name)
                .font(.subheadline)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .background(Capsule().foregroundColor(.purple))
                .matchedGeometryEffect(id: "highlightmenuitem", in: namespace)
        } else {
            Text(name)
                .font(.subheadline)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    @Namespace var menuItemTransition
    return TabbarItem(name: "Name", isActive: true, namespace: menuItemTransition)
}
