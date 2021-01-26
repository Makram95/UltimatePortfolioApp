//
//  Projects-CoreDataHelpers.swift
//  UltimatePortfolio
//
//  Created by Marc on 21.01.21.
//

import Foundation


extension Project {
    
    static let colors = ["Pink","Purple","Red","Orange","Gold","Green","Teal","Light Blue","Dark Blue","Midnight","Dark Gray","Gray"]
    
    var projectTitle: String {
        title ?? NSLocalizedString("New Project", comment: "Create a new project")
    }
    var projectDetail: String {
        detail ?? ""
    }
    var projectCreationDate: Date{
        creationDate ?? Date()
    }
    var projectColor: String{
        color ?? "Light Blue"
    }
    
    var projectItems: [Item]{
        items?.allObjects as? [Item] ?? []
    }
    
    var projectItemsDefaultSorted: [Item]{
       
        
        projectItems.sorted{ first, second in
            if first.completed == false {
                if second.completed {
                    return true
                }
            }else if first.completed {
                if second.completed == false{
                    return false
                }
            }
            if first.priority > second.priority{
                return true
            }else if first.priority < second.priority{
                return false
            }
            return first.itemCreationDate < second.itemCreationDate
        }
    }
    
    var completionAmmount: Double{
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else {
            return 0
        }
        let completed = originalItems.filter(\.completed)
        return Double(completed.count)/Double(originalItems.count)
    }
    
    static var example: Project {
        let controler = DataController(inMemory: true)
        let viewContext = controler.container.viewContext
        
        let project = Project(context: viewContext)
        project.title = "Example Project"
        project.detail = "This is an example Project"
        project.closed = true;
        project.creationDate = Date()
        
        return project
    }
    
    func projectItems(using sortOrder: Item.SortOrder) -> [Item]{
        switch sortOrder{
        case .title:
            return projectItems.sorted(by: \Item.itemTitle)
        case .creationDate:
            return projectItems.sorted(by: \Item.itemCreationDate)
        case.optimized:
            return projectItemsDefaultSorted
            
        }
    }
}
