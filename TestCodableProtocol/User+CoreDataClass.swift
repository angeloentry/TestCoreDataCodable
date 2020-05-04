//
//  User+CoreDataClass.swift
//  
//
//  Created by Allen Savio on 3/28/19.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case age
        case name
        case company
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.age = try container.decode(String.self, forKey: .age)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.company = try container.decode(Company.self, forKey: .company)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(age, forKey: .age)
        try container.encode(name, forKey: .name)
        try container.encode(company, forKey: .company)
    }
}
