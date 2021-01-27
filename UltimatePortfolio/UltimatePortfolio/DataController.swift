//
//  DataController.swift
//  UltimatePortfolio
//
//  Created by Marc on 21.01.21.
//

import SwiftUI
import CoreData

///  An environment singleton responsible for managing our CoreData stack, including saving, counting fetch requests etc.
class DataController: ObservableObject {

    /// The lone CloudKit container used to store all our data
    let container: NSPersistentCloudKitContainer


    /// initializes a data controller either in memory for temporary use, or on permanent storage.
    ///
    /// Defaults to permanent storage
    /// - Parameter inMemory: Whether to store data in temporary or not
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main") // main is name of Model-file

        // for testing and previewing we create data at temporary location, so thats it is automatically reset on relaunch
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores {_, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }

    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext

        do {
            try dataController.createSampleDate()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        return dataController
    }()

    /// Creates sample projects and items
    /// - Throws: NSError sent from calling save() on the NSManagedObjectContext
    func createSampleDate() throws {
        let viewContext = container.viewContext // pool of data that is loaded from disc and active right now

        for projectCounter in 1...5 {
            let project = Project(context: viewContext)
            project.title = "Project \(projectCounter)"
            project.items = []
            project.creationDate = Date()
            project.closed = Bool.random()

            for itemCounter in 1...10 {
                let item = Item(context: viewContext)
                item.title = "Item \(itemCounter)"
                item.creationDate = Date()
                item.completed = Bool.random()
                item.project=project
                item.priority = Int16.random(in: 1...3)
            }
        }
        try viewContext.save()
    }

    /// Saves our CoreData context iff there are changes, ignores any errors
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }

    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)

        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = Project.fetchRequest()
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        _ = try? container.viewContext.execute(batchDeleteRequest2)
    }

    func count<T>(for fetchRequest: NSFetchRequest<T>) -> Int {
        (try? container.viewContext.count(for: fetchRequest)) ?? 0
    }

    func hasEarned(award: Award) -> Bool {
        switch award.criterion {
        case "items":
            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        case "complete":
            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
            fetchRequest.predicate = NSPredicate(format: "completed = true")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        default:
        // fatalError("Unknown award criterion: \(award.criterion)")
        return false
        }
    }
}
