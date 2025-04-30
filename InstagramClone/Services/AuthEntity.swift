//
//  AuthEntity.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 29/04/25.
//

import Foundation

struct AuthEntity {
   var email: String
   var password: String
   var fullname: String
   var username: String
   var userId: String?
   var profileImageURL: String?
   
   func toDictionary() -> [String : String] {
      var data = [
         "email" : email,
         "fullname" : fullname,
         "username" : username,
      ]
      
      if let profileImageURL {
         data["profileImageURL"] = profileImageURL
      }
      
      if let userId {
         data["userId"] = userId
      }
      
      return data
   }
}

