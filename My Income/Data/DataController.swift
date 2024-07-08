//
//  DataController.swift
//  My Income
//
//  Created by Lalu Iman Abdullah on 08/07/24.
//

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Income")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
        }
    }

    func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
