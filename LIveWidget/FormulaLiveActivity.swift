//
//  LIveWidgetLiveActivity.swift
//  LIveWidget
//
//  Created by Chikinov Maxim on 07.06.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct FormulaLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FormulaAttributes.self) { context in
            FormulaActivityWidgetLockView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Это содержимое будет отображаться, когда пользователь расширяет Island
                
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        Text("Driver in front is \(context.state.driverInFront) 🏎")
                        Text("Last place driver is \(context.attributes.lastPlaceDriver)")
                    }
                }
                
            } compactLeading: {
                // Это представление отображается в левой части Dynamic Island
                Text("🏎")
            } compactTrailing: {
                // Это представление отображается в правой части Dynamic Island
                Image(systemName: "timer")
            } minimal: {
                //  Это представление будет отображаться, когда одновременно запущено несколько Activity
                Text("🏎")
            }
        }
    }
}

struct FormulaActivityWidgetLockView: View {
    var context: ActivityViewContext<FormulaAttributes>
    
    var body: some View {
        VStack {
            Text(context.state.driverInFront)
            Text(context.state.driverTeam)
        }
        .activitySystemActionForegroundColor(.white)
        .activityBackgroundTint(.cyan)
    }
}

#Preview("Notification", as: .content, using: FormulaAttributes.preview) {
    FormulaLiveActivity()
} contentStates: {
    FormulaAttributes.ContentState.one
    FormulaAttributes.ContentState.two
}
