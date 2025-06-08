//
//  UserEntity.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 13/05/25.
//

import Foundation

struct UserEntity: Codable {
   var email: String = Constants.infoUnavailable
   var fullName: String = Constants.infoUnavailable
   var username: String = Constants.infoUnavailable
   var userId: String = Constants.infoUnavailable
   var profileImageURL: String? = nil
   var followersCount: Int = 0
   var followingsCount: Int = 0
   var postsCount: Int = 0
}

private extension UserEntity {
   enum Constants {
      static let infoUnavailable = "Info Unavailable"
   }
}
