//
//  TabbarItem.swift
//  Formula
//
//  Created by Chikinov Maxim on 31.05.2024.
//

import SwiftUI

struct TabBarItemVieModel: Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var color: Color
    
    init(tab: Tab) {
        self.id = tab.rawValue
        self.name = tab.text
        self.imageName = tab.imageName
        self.color = tab.color
    }
}

struct TabBarItem: View {
    var model: TabBarItemVieModel
    var isActive: Bool = false
    let namespace: Namespace.ID

    var body: some View {
        if isActive {
            HStack {
                Image(systemName: model.imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .scaledToFit()
                Text(model.name.capitalized)
                    .font(.subheadline)
                    .matchedGeometryEffect(id: "highlightmenuitem", in: namespace)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(Capsule().foregroundColor(model.color))
            .foregroundColor(.white)
        } else {
            Text(model.name.capitalized)
                .font(.subheadline)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    @Namespace var menuItemTransition
    return TabBarItem(
        model: TabBarItemVieModel(tab: Tab.main),
        isActive: true,
        namespace: menuItemTransition
    )
}
