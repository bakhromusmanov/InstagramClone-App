//  UserEndpoint.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 30/04/25.
//

import Foundation

enum ImageEndpoint {
   case profileImage
   case postImage
   
   var path: String {
      switch self {
      case .profileImage:
         let userId = "userId"
         return "/users\(userId)/images/profile_image.jpg"
      case .postImage:
         let userId = "userId"
         let fileName = UUID().uuidString
         return "/users\(userId)/images/post_images/\(fileName).jpg"
      }
   }
}
