//
//  Profile+CoreDataProperties.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 27.03.2022.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: String?
    @NSManaged public var sex: String?
    @NSManaged public var image: Data?
    @NSManaged public var parameters: NSOrderedSet?

}

// MARK: Generated accessors for parameters
extension Profile {

    @objc(insertObject:inParametersAtIndex:)
    @NSManaged public func insertIntoParameters(_ value: BodyParameter, at idx: Int)

    @objc(removeObjectFromParametersAtIndex:)
    @NSManaged public func removeFromParameters(at idx: Int)

    @objc(insertParameters:atIndexes:)
    @NSManaged public func insertIntoParameters(_ values: [BodyParameter], at indexes: NSIndexSet)

    @objc(removeParametersAtIndexes:)
    @NSManaged public func removeFromParameters(at indexes: NSIndexSet)

    @objc(replaceObjectInParametersAtIndex:withObject:)
    @NSManaged public func replaceParameters(at idx: Int, with value: BodyParameter)

    @objc(replaceParametersAtIndexes:withParameters:)
    @NSManaged public func replaceParameters(at indexes: NSIndexSet, with values: [BodyParameter])

    @objc(addParametersObject:)
    @NSManaged public func addToParameters(_ value: BodyParameter)

    @objc(removeParametersObject:)
    @NSManaged public func removeFromParameters(_ value: BodyParameter)

    @objc(addParameters:)
    @NSManaged public func addToParameters(_ values: NSOrderedSet)

    @objc(removeParameters:)
    @NSManaged public func removeFromParameters(_ values: NSOrderedSet)

}

extension Profile : Identifiable {

}
