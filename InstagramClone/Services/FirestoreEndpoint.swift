//
//  UserEndpoint.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 30/04/25.
//

import Foundation

enum FirestoreEndpoint {
   case users
   case follows
   case followers
   case followings
   
   var path: String {
      switch self {
      case .users:
         return "users/"
      case .follows:
         return "follows"
      case .followers:
         return "followers"
      case .followings:
         return "followings"
      }
   }
}
