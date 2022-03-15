//
//  Profile+CoreDataProperties.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 15.03.2022.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var sex: String?
    @NSManaged public var name: String?

}

extension Profile : Identifiable {

}
