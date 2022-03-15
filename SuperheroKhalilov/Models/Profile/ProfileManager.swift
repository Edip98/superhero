//
//  ProfileManager.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import Foundation
import CoreData

class ProfileManager {
    
    static let sharedInstance = ProfileManager()
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Profile")
        container.loadPersistentStores { storeDEscription, error in
            if let error = error as NSError? {
                print("Error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var userProfile: Profile?
    
    func createDefaultProfile(with sex: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Profile", in: mainContext)
        userProfile = Profile(entity: entity!, insertInto: mainContext)
        
        userProfile?.sex = sex
        userProfile?.name = ""
        saveProfile()
    }
    
    func saveProfile() {
        guard mainContext.hasChanges else { return }
        
        do {
            try mainContext.save()
        } catch let nserror as NSError {
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func fetchProfile() {
        let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
        
        do {
            let result = try mainContext.fetch(fetchRequest)
            
            if result.count > 0 {
                userProfile = result.first
            } else {
                userProfile = nil
            }
        } catch let error as NSError  {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
}

