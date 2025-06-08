//
//  PostEntity.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 07/06/25.
//

import Foundation
import FirebaseCore

struct PostEntity: Codable {
   var postId: String
   var userId: String
   var profileImageUrl: String?
   var postImageUrl: String
   var username: String
   var caption: String = ""
   var likesCount: Int = 0
   var timestamp: Timestamp
}
