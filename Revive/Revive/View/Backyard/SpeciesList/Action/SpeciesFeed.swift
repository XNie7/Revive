//
//  SpeciesFeed.swift
//  Revive
//
//  Created by Kaile Ying on 12/3/23.
//

import SwiftUI

struct SpeciesFeed: View {
    @Environment(ReviveManager.self) var manager
    private let adaptiveCloumns = [GridItem(.adaptive(minimum: 70))]
    
    var body: some View {
        @Bindable var manager = manager
        VStack {
            ScrollView {
                LazyVGrid(columns: adaptiveCloumns, spacing: 20, content: {
                    ForEach(manager.myItems.indices, id: \.self) { i in
                        if manager.getItem(id: manager.myItems[i].id).functionType.contains(.exp) && manager.getItem(id: manager.myItems[i].id).trait.contains(manager.getSpecies(mySpecies: manager.currPanelSpecies!).trait) {
                            ItemBYListImage(currItem: $manager.myItems[i], currModule: $manager.currPanelItem)
                        }
                    }
                })
                .onAppear {
                    manager.currPanelItem = nil
                }
            }
            
            Button(action: { manager.itemBuff() }, label: {
                Text("Feed")
                    .font(.custom("Georgia-Italic", size: 18))
                    .foregroundStyle(.white)
                    .bold()
                    .padding(10)
                    .padding(.horizontal, 40)
            })
            .background(Color.cDarkOrange)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 0.7, x: 2, y: 3)
            .padding(.top)
        }
    }
}
