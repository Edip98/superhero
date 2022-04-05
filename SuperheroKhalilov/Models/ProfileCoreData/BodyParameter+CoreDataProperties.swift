//
//  BodyParameter+CoreDataProperties.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 02.04.2022.
//
//

import Foundation
import CoreData


extension BodyParameter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BodyParameter> {
        return NSFetchRequest<BodyParameter>(entityName: "BodyParameter")
    }

    @NSManaged public var bodyPart: String?
    @NSManaged public var changeValue: Int16
    @NSManaged public var isSelected: Bool
    @NSManaged public var value: Int16
    @NSManaged public var isOn: Bool
    @NSManaged public var profile: Profile?

}

extension BodyParameter : Identifiable {

}
