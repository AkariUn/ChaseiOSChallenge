//
//  SchoolDataService.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation
import CoreData

class SchoolDataService : DataServiceProtocol {

    typealias schoolCallback = ([SchoolModel]) -> Void
    
    let BASE_URL = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    
    var context:NSManagedObjectContext
    
    init(context:NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchData(_ completion: @escaping schoolCallback) {
        if let cache = loadCachedData() {
            // cache found, no need to bring data from network
            completion(cache)
            return
        }
        
        loadNetworkData(completion)
    }
    
    // this func fetches from network using url session
    private func loadNetworkData(_ completion: @escaping schoolCallback) {
        
        guard let url = URL(string: BASE_URL) else {
            completion([])
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        // capture managedObjectContext to not capture weak self
        let managedObjectContext = self.context
        
        let task = session.dataTask(with: request) { taskData, response, error in
           
            guard let taskData = taskData else {
                completion([])
                return
            }
            
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = managedObjectContext

            guard let schoolList: [SchoolModel] = try? decoder.decode([SchoolModel].self, from: taskData) else {
                completion([])
                return
            }
            completion(schoolList)
            
            // Save data to cache after callback
            SchoolDataService.saveDataToCache(managedObjectContext)

        }

        task.resume()
    }
    
    // this func fetches cache from Core Data
    private func loadCachedData() -> [SchoolModel]? {
        do {
            let cachedResults = try context.fetch(SchoolModel.fetchRequest())
            // if no results return nil so we can fecth from network
            return cachedResults.count == 0 ? nil : cachedResults
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
