//
//  SatViewModel.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation

class SatViewModel: NSObject {
    
    var school: SchoolModel
    var satScore: SatModel?
    
    // Service that fetchs schools.
    var appService:any DataServiceProtocol
    
    // This could also be a listener subscriber system but for this use case a block works.
    private var completion:(() -> Void)?
    
    init(withSchool school:SchoolModel, provider:DataServiceProviderProtocol) {
        self.school = school
        self.appService = provider.getScoresDataService(school: school)
    }

    func setCallback(completion:@escaping () -> Void) {
        self.completion = completion
    }
    
    // fetch data regardless of the data source
    func loadData() {
        self.appService.fetchData { [weak self] result in
            guard let self,
                  let result = result as? SatModel else {
                self?.completion?()
                return
            }
            self.satScore = result
            self.completion?()
        }
    }
}
