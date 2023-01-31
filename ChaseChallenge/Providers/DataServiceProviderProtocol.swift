//
//  DataServiceProviderProtocol.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation

protocol DataServiceProviderProtocol {
    func getSchoolDataService() -> any DataServiceProtocol
    
    func getScoresDataService(school:SchoolModel) -> any DataServiceProtocol

}
