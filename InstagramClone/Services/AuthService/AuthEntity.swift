//
//  AuthEntity.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 29/04/25.
//

import Foundation

struct AuthEntity: Codable {
   var email: String
   var password: String
   var fullName: String
   var username: String
   var profileImageURL: String?
}
