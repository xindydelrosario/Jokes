//
//  Jokes+CoreDataProperties.swift
//  RandomJoke
//
//  Created by xindy.del.rosario on 12/2/22.
//
//

import Foundation
import CoreData


extension Jokes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Jokes> {
        return NSFetchRequest<Jokes>(entityName: "Jokes")
    }

    @NSManaged public var setup: String?
    @NSManaged public var punchline: String?

}

extension Jokes : Identifiable {

}
