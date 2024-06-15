//
//  OffsetObservingScrollView.swift
//  Formula
//
//  Created by Chikinov Maxim on 15.06.2024.
//

import SwiftUI

struct OffsetObservingScrollView<Content: View>: View {
    var axis: Axis.Set = [.vertical]
    var showsIndicators = true
    
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content
    
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        ScrollView(axis, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(x: -newOffset.x, y: -newOffset.y)
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}

struct PositionObservingView<Content: View>: View {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
    }
    
    var coordinateSpace: CoordinateSpace
    
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .background(GeometryReader { geometry in
                Color.clear.preference(
                    key: PreferenceKey.self,
                    value: geometry.frame(in: coordinateSpace).origin
                )
            })
            .onPreferenceChange(PreferenceKey.self) { position in
                self.position = position
            }
    }
}
