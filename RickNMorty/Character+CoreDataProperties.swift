//
//  Character+CoreDataProperties.swift
//  RickNMorty
//
//  Created by admin on 8.08.2023.
//

import CoreData

public extension Character {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Character> {
        NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged var characterID: String
    @NSManaged var name: String?
    @NSManaged var imageURLString: String?
}

extension Character: Identifiable {}
