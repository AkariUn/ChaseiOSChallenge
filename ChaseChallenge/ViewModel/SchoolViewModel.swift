//
//  SchoolViewModel.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation

class SchoolViewModel: NSObject {
    
    var schools: [SchoolModel]
    
    // Service that fetchs schools.
    var appService:any DataServiceProtocol
    
    // Service that fetchs schools.
    var provider:any DataServiceProviderProtocol
    
    // This could also be a listener subscriber system but for this use case a block works.
    private var completion:() -> Void
    
    init(withProvider provider:DataServiceProviderProtocol, completion:@escaping () -> Void) {
        self.schools = []
        self.provider = provider
        self.appService = provider.getSchoolDataService()
        self.completion = completion
    }

    // fetch data regardless of the data source
    func loadData() {
        self.appService.fetchData { [weak self] result in
            guard let self,
            let results = result as? [SchoolModel] else {
                self?.completion()
                return
            }
            self.schools = results
            self.completion()
        }
    }
}
