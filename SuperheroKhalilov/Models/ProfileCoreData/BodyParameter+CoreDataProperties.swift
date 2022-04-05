//
//  BodyParameter+CoreDataProperties.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 27.03.2022.
//
//

import Foundation
import CoreData


extension BodyParameter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BodyParameter> {
        return NSFetchRequest<BodyParameter>(entityName: "BodyParameter")
    }

    @NSManaged public var bodyPart: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var value: Int16
    @NSManaged public var profile: Profile?

}

extension BodyParameter : Identifiable {

}
