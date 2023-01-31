//
//  CodingUserInfoKeyExtension.swift
//  ChaseChallenge
//
//  Created by Adan Garcia on 30/01/23.
//

import Foundation

/*
 In order to being able to use CoreData classes and JSON encodable, we need to add
 the managedObjectContext to JSON decoder Info so in the initializer we can get access to
 it
 */
extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

/*
 This is just an error that will be thrown in case the managedObjectContext is not added to
 JSONDecoder Info
 */
enum DecoderError: Error {
  case missingContext
}
