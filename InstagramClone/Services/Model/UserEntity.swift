//
//  UserEntity.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 13/05/25.
//

import Foundation

struct UserEntity: Codable {
   var email: String
   var fullname: String
   var username: String
   var userId: String
   var profileImageURL: String?
}
