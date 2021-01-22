//
//  Item-CoreDataHelpers.swift
//  UltimatePortfolio
//
//  Created by Marc on 21.01.21.
//

import Foundation

extension Item {
    
    var itemTitle: String {
        title ?? "New Item"
    }
    var itemDetail: String {
        detail ?? ""
    }
    var itemCreationDate: Date{
        creationDate ?? Date()
    }
    
    static var example: Item {
        let controler = DataController(inMemory: true)
        let viewContext = controler.container.viewContext
        
        let item = Item(context: viewContext)
        item.title = "Example Item"
        item.detail = " This is an example item"
        item.priority = 3
        item.creationDate = Date()
        
        return item
    }
}
