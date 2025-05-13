//
//  UserEndpoint.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 30/04/25.
//

import Foundation

enum UserEndpoint {
   case user(uid: String)
   
   var path: String {
      switch self {
      case .user(let uid):
         return "users/\(uid)"
      }
   }
}
