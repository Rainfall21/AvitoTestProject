//
//  HistorySavingController.swift
//  AvitoTestProject
//
//  Created by Alibek Ismagulov on 13.04.2024.
//

import Foundation


//MARK: - UserDefaults funcs
// UserDefaults funcs to save and read data for search history
class HistorySavingController {
    func saveData(_ searchText : String) {
        
        var searchArray = readData()
        if searchArray.count == 5 {
            searchArray.remove(at: 0)
        }
        searchArray.append(searchText)
        let defaults = UserDefaults.standard
        defaults.set(searchArray, forKey: "SearchHistory")
        
    }
    
    func readData() -> [String] {
        
        let defaults = UserDefaults.standard
        var array = defaults.object(forKey: "SearchHistory") as? [String] ?? [String]()
        array = Array(Set(array))
        
        return array
    }
}
