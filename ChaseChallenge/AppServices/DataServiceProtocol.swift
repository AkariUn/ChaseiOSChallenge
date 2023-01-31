//
//  DataServiceProtocol.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation
/**
 Simple Data service protocol, in case we want to use a different
 approach on how consume data, as long as conforms this protocol
 VIew model and its dependencies will not be affected
*/
protocol DataServiceProtocol {
    associatedtype T
    func fetchData(_ completion:@escaping(T) -> Void)
}
