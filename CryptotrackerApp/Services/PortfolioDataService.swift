//
//  PortfolioDataService.swift
//  CryptotrackerApp
//
//  Created by Kyungyun Lee on 11/04/2022.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container : NSPersistentContainer
    private let containerName : String = "PortfolioContainer"
    private let entityName : String = "PortfolioEntity"
    
    @Published var savedEntities : [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Coredata")
            }
            self.getPortfolio()
        }
    }
    
    func updatePortfolio(coin : CoinModel, amount : Double) {
//        if let entity = savedEntities.first(where: { (savedEntity) in
//            return savedEntity.coinID == coin.id
//        }) {
//
//        }
        
        //check if coin is already in portfolio
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error to fetch data = \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount : Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity : PortfolioEntity, amount : Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity : PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("error to save data")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
    
}
