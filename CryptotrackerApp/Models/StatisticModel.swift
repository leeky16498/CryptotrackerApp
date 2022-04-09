//
//  StatisticModel.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 09/04/2022.
//

import Foundation

struct StatisticModel : Identifiable {
    
    let id = UUID()
    let title : String
    let value : String
    let percentageChange : Double?
    
    init(title : String, value : String, percentageChange : Double?) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
