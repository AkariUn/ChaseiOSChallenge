//
//  SATDataService.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation
import CoreData

class SatDataService : DataServiceProtocol {

    typealias SatCallback = (SatModel?) -> Void
    
    let BASE_URL = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn="
    
    var school:SchoolModel
    var context:NSManagedObjectContext
    
    init(school:SchoolModel, context:NSManagedObjectContext) {
        self.school = school
        self.context = context
    }
    
    func fetchData(_ completion: @escaping SatCallback) {
        guard let dbn = self.school.dbn else {
            completion(nil)
            return
        }
        
        if let cache = loadCachedData(dbn: dbn) {
            // cache found, no need to bring data from network
            completion(cache)
            return
        }
        
        loadNetworkData(completion)
    }
    
    // this func fetches from network using url session
    private func loadNetworkData(_ completion: @escaping SatCallback) {
        
        guard let dbn = self.school.dbn,
            let url = URL(string: BASE_URL + dbn) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        // capture managedObjectContext to not capture weak self
        let managedObjectContext = self.context
        
        let task = session.dataTask(with: request) { taskData, response, error in
           
            guard let taskData = taskData else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = managedObjectContext

            guard let satScore:SatModel = (try? decoder.decode([SatModel].self, from: taskData))?.first else {
                completion(nil)
                return
            }
            completion(satScore)
            
            // Save data to cache after callback
            SatDataService.saveDataToCache(managedObjectContext)

        }

        task.resume()
    }
    
    // this func fetches cache from Core Data
    private func loadCachedData(dbn:String) -> SatModel? {
        do {
            let cachedResult = try context.fetch(SatModel.fetchRequest(dbn: dbn)).first
            return cachedResult
        } catch {
            // in case of any error return nil as well
            return nil
        }
    }
    
    private static func saveDataToCache(_ context:NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            // in case of any error no op
        }
    }
}
