//
//  StoreView.swift
//  Revive
//
//  Created by Kaile Ying on 12/16/23.
//

import SwiftUI

struct StoreView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                
                VStack (spacing: 0) {
                    StoreTitle()
                    Spacer()
                    
                    HStack {
                        Spacer()
                        CoinView()
                            .padding(.horizontal)
                    }
                    .padding(.bottom, -70)
                    
                    SeasomeHuStore()
                    ScrollView {
                        ForEach(0..<4) { i in
                            StoreImage()
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 10)
                    .background(Color.cBlackBrown)
                }
            }
        }
    }
}
