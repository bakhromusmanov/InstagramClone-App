//  UserEndpoint.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 30/04/25.
//

import Foundation

enum ImageEndpoint {
   case profileImage(username: String)
   case postImage(username: String)
   
   var path: String {
      switch self {
      case .profileImage(let username):
         return "/users/\(username)/images/profile_image.jpg"
      case .postImage(let username):
         let fileName = UUID().uuidString
         return "/users/\(username)/images/post_images/\(fileName).jpg"
      }
   }
}
