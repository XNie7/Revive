//
//  ReviveWidgetLiveActivity.swift
//  ReviveWidget
//
//  Created by Kaile Ying on 12/5/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ReviveWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ReviveWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                Image(context.state.ImageName)
                    .resizable()
                    .scaledToFit()
                    .padding(30)
                
                Spacer()
                
                VStack {
                    Text("Time left")
                        .font(.custom("Georgia-Italic", size: 20))
                        .padding(5)
                        .bold()
                        .foregroundStyle(Color.cBlack)
                    Text("\(context.state.timeLeft)")
                        .font(.custom("Georgia-Italic", size: 30))
                        .padding(5)
                        .bold()
                        .foregroundStyle(Color.cBlack)
                }
                
                Spacer()
            }
            .background(Color(red: 0.8672, green: 0.9961, blue: 0.9922))
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            .onAppear {
                print(123123)
            }

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.timeLeft)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.timeLeft)")
            } minimal: {
                Text(context.state.timeLeft)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

//extension ReviveWidgetAttributes {
//    fileprivate static var preview: ReviveWidgetAttributes {
//        ReviveWidgetAttributes(action: "World")
//    }
//}
//
//extension ReviveWidgetAttributes.ContentState {
//    fileprivate static var test: ReviveWidgetAttributes.ContentState {
//        ReviveWidgetAttributes.ContentState(timeLeft: "10", ImageName: "1001")
//     }
//     
//     fileprivate static var starEyes: ReviveWidgetAttributes.ContentState {
//         ReviveWidgetAttributes.ContentState(emoji: "🤩")
//     }
//}

    //#Preview("Notification", as: .content, using: ReviveWidgetAttributes.preview) {
    //   ReviveWidgetLiveActivity()
    //} contentStates: {
    //    ReviveWidgetAttributes.ContentState.test
    //}
