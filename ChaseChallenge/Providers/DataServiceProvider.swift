//
//  DataServiceProvider.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation
import UIKit
import CoreData

class DataServiceProvider : DataServiceProviderProtocol {
    
    var context:NSManagedObjectContext
    
    init (context:NSManagedObjectContext) {
        self.context = context
    }
    
    func getSchoolDataService() -> any DataServiceProtocol {
        return SchoolDataService(context: context)
    }
    
    func getScoresDataService(school:SchoolModel) -> any DataServiceProtocol {
        
        return SatDataService(school: school, context: context)
    }
    
    
}
