//
//  ReviveManager+Backyard.swift
//  Revive
//
//  Created by Kaile Ying on 11/10/23.
//

import Foundation
import SwiftUI

extension ReviveManager {
    func getSpecies(mySpecies: MySpecies) -> Species {
        return speciesList[mySpecies.speciesID-1]
    }
    
    func SpeciesFavorToggle(id: Int, date: Date) {
        for i in (0..<mySpecies.count) {
            if mySpecies[i].hatchDate == date && mySpecies[i].speciesID == id {
                mySpecies[i].favorite.toggle()
            }
        }
    }
    
    func getCurrSpeciesTotalExp(id: Int, date: Date) -> Int {
        for i in (0..<mySpecies.count) {
            if mySpecies[i].hatchDate == date && mySpecies[i].speciesID == id {
                return 10 * 60 + (mySpecies[i].level-1) * 70
            }
        }
        return 1
    }
    
    func canEvolve() -> Bool {
        if getSpecies(mySpecies: currPanelSpecies!).evolveAt != nil && currPanelSpecies?.level ?? 999 >= getSpecies(mySpecies: currPanelSpecies!).evolveAt! {
            return true
        }
        
        return false
    }
    
    func getMyPanelItem(id: Int) -> MyItems {
        for x in myItems {
            if x.id == id {
                return x
            }
        }
        
        return myItems[0]
    }
    
    func getTraitBGColor(trait: Trait) -> Color {
        if trait == .carnivore {
            return Color.cRed
        } else if trait == .herbivore {
            return Color.cGreen
        } else {
            return Color.cBlue
        }
    }
    
    func evolveToNextStage() {
        let targetSpecies = speciesList[currPanelSpecies!.speciesID+1]
        let maxHeight = targetSpecies.height.L
        let minHeight = targetSpecies.height.S
        let maxWeight = targetSpecies.weight.L
        let minWeight = targetSpecies.weight.S
        let randomHeight = Double.random(in: minHeight...maxHeight)
        let randomWeight = Double.random(in: minWeight...maxWeight)
        
        let index = getSpeciesIndex(id: currPanelSpecies!.speciesID, date: currPanelSpecies!.hatchDate)
        mySpecies[index] = MySpecies(
            speciesID: currPanelSpecies!.speciesID+1,
            nickName: currPanelSpecies!.nickName,
            level: currPanelSpecies!.level,
            currExp: currPanelSpecies!.currExp,
            height: randomHeight,
            weight: randomWeight,
            favorite: currPanelSpecies!.favorite,
            hatchDate: currPanelSpecies!.hatchDate
        )
        
        deleteSpecies(id: currPanelSpecies!.speciesID, date: currPanelSpecies!.hatchDate)
        currPanelSpecies = mySpecies[index]
        saveNewSpecies(mySpecies: mySpecies[index])
    }
    
    func changeItemListSorter() {
        switch itemListSort {
        case .alphabet:
            myItems.sort()
            
        case .amount:
            myItems = myItems.sorted{ $0.amount > $1.amount }
        }
    }
    
    func changeSpeciesListSorter() {
        switch speciesListSort {
        case .alphabet:
            mySpecies.sort()
            
        case .favorite:
            var favor = mySpecies.filter{ $0.favorite == true }
            var unfavor = mySpecies.filter{ $0.favorite == false }
            favor.sort()
            unfavor.sort()
            mySpecies = favor + unfavor
            
        case .level:
            mySpecies = mySpecies.sorted{ $0.level > $1.level }
            
        case .rarity:
            var SSR = mySpecies.filter{ getSpecies(mySpecies: $0).rarity == "SSR" }
            var SR = mySpecies.filter{ getSpecies(mySpecies: $0).rarity == "SR" }
            var R = mySpecies.filter{ getSpecies(mySpecies: $0).rarity == "R" }
            SSR.sort()
            SR.sort()
            R.sort()
            mySpecies = SSR + SR + R
            
        case .hatchingDate:
            mySpecies = mySpecies.sorted{ $0.hatchDate > $1.hatchDate }
        }
    }
    
    func deleteSpecies(id: Int, date: Date) {
        DataManager.shared.deleteMySpecies(for: id, for: date, mySpecies: mySpecies)
    }
    
    func saveNewSpecies(mySpecies: MySpecies) {
        DataManager.shared.saveData(customItem: mySpecies)
    }
    
    func getAdvantageAreaColor(area: String) -> Color {
        switch area {
        case "Plain":
            return Color(red: 0.1797, green: 0.7969, blue: 0.4414)
        case "Desert":
            return Color(red: 0.9492, green: 0.6094, blue: 0.0703)
        case "Rainforest":
            return Color(red: 0.0859, green: 0.6250, blue: 0.5195)
        case "Ocean":
            return Color(red: 0.1602, green: 0.5000, blue: 0.7227)
        case "Glacier":
            return Color(hue: 204, saturation: 0.05, brightness: 0.67)
        case "River":
            return Color(red: 0.2031, green: 0.5938, blue: 0.8555)
        case "Beach":
            return Color(red: 0.9414, green: 0.7656, blue: 0.0586)
        case "Volcano":
            return Color(red: 0.6601, green: 0.1953, blue: 0.1484)
        case "Sky":
            return Color(red: 0.4961, green: 0.6992, blue: 0.8320)
            
        default:
            return .cBlack
        }
    }
}
