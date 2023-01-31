//
//  SatModel.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation
import CoreData

@objc(SatModel)

/**
 Usually this is CodeGen, but as I wanted to use both JSON decoder with
 Core data models, the entity class needs to be created manually
 */
public class SatModel: NSManagedObject, Decodable {
    static let ENTITY_NAME = "SatScores"

    @NSManaged public var dbn: String?
    @NSManaged public var name: String?
    @NSManaged public var testTakers: String?
    @NSManaged public var readScores: String?
    @NSManaged public var mathScores: String?
    @NSManaged public var writingScores: String?
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderError.missingContext
            }

        self.init(context: context)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.dbn = try values.decode(String.self, forKey: .dbn)
        self.name = try values.decode(String.self, forKey: .name)
        self.testTakers = try values.decode(String.self, forKey: .testTakers)
        self.readScores = try values.decode(String.self, forKey: .readScores)
        self.mathScores = try values.decode(String.self, forKey: .mathScores)
        self.writingScores = try values.decode(String.self, forKey: .writingScores)
        
      }
    
    @nonobjc public class func fetchRequest(dbn:String) -> NSFetchRequest<SatModel> {
        let request = NSFetchRequest<SatModel>(entityName: SatModel.ENTITY_NAME)
        request.predicate = NSPredicate(format: "dbn = %@", dbn)
        return request
    }

}

/**
 Extension for JSON mapping
*/
extension SatModel {
    enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case testTakers = "num_of_sat_test_takers"
        case readScores = "sat_critical_reading_avg_score"
        case mathScores = "sat_math_avg_score"
        case writingScores = "sat_writing_avg_score"
      }
}

