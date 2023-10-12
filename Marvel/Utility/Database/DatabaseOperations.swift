//
//  DatabaseOperations.swift
//  Marvel
//
//  Created by Abhishek on 12/10/23.
//

import Foundation
import CoreData
class DatabaseOperations{
    
    let context = appDelegate?.persistentContainer.viewContext
    
    static var shared = DatabaseOperations()
    
    public func saveItems(){
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = appDelegate?.persistentContainer.persistentStoreCoordinator
        privateContext.perform {[weak self] in
            do{
                try self?.context?.save()
            }catch{
                print("Error while context \(error.localizedDescription)")
            }
        }
    }
    
    public func loadItems() -> [UserSearches]?{
        let request: NSFetchRequest<UserSearches> = UserSearches.fetchRequest()
        do{
            return try context?.fetch(request)
        }catch{
            print("Error fetching request \(error.localizedDescription)")
        }
        return nil
    }
    
}
