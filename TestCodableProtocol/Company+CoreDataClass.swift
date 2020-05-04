//
//  Company+CoreDataClass.swift
//  
//
//  Created by Allen Savio on 3/28/19.
//
//

import Foundation
import CoreData

@objc(Company)
public class Company: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case domain
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Company", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.domain = try container.decode(String.self, forKey: .domain)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(domain, forKey: .domain)
    }
}
