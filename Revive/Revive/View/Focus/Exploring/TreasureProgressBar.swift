//
//  TreasureProgressBar.swift
//  Revive
//
//  Created by Kaile Ying on 12/1/23.
//

import SwiftUI

struct TreasureProgressBar: View {
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @Environment(ReviveManager.self) var manager
    var widthPercent : Double
    
    var body: some View {
        @Bindable var manager = manager
        var percentBinding: Binding<CGFloat> {
            Binding<CGFloat>(
                get: {
                    CGFloat(Double(manager.currExploringMap!.currTime) / Double(manager.getLastNextPoint().1 - manager.getLastNextPoint().0))
                },
                set: { _ in }
            )
        }
        
        ProgressBar(color1: .cDarkOrange, color2: .cDarkOrange, percent: percentBinding, widthPercent: widthPercent, height: 10)
    }
}