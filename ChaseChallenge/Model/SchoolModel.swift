//
//  School+CoreDataClass.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//
//

import Foundation
import CoreData

@objc(SchoolModel)

/**
 Usually this is CodeGen, but as I wanted to use both JSON decoder with
 Core data models, the entity class needs to be created manually
 */
public class SchoolModel: NSManagedObject, Decodable {
    static let ENTITY_NAME = "School"
    
    @NSManaged public var dbn: String?
    @NSManaged public var name: String?
    @NSManaged public var overview: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var totalStudents: String?
    @NSManaged public var address: String?
    @NSManaged public var grades: String?
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderError.missingContext
            }

        self.init(context: context)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.dbn = try values.decode(String.self, forKey: .dbn)
        self.name = try values.decode(String.self, forKey: .name)
        self.overview = try values.decode(String.self, forKey: .overview)
        self.city = try values.decode(String.self, forKey: .city)
        self.state = try values.decode(String.self, forKey: .state)
        self.phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        self.totalStudents = try values.decode(String.self, forKey: .totalStudents)
        self.address = try values.decode(String.self, forKey: .address)
        self.grades = try values.decode(String.self, forKey: .grades)
        
      }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SchoolModel> {
        return NSFetchRequest<SchoolModel>(entityName: SchoolModel.ENTITY_NAME)
        
    }

}

/**
 Extension for JSON mapping
*/
extension SchoolModel {
    enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case overview = "overview_paragraph"
        case city
        case state = "state_code"
        case phoneNumber = "phone_number"
        case totalStudents = "total_students"
        case address = "location"
        case grades = "finalgrades"
      }
}

