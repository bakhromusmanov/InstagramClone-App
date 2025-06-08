//
//  UserEndpoint.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 30/04/25.
//

import Foundation
import FirebaseFirestore

let COLLECTION_USERS = Firestore.firestore().collection(FirestoreEndpoint.users.path)
let COLLECTION_FOLLOWERS = FirestoreEndpoint.followers.path
let COLLECTION_FOLLOWINGS = FirestoreEndpoint.followings.path
let COLLECTION_POSTS = Firestore.firestore().collection(FirestoreEndpoint.posts.path)

private enum FirestoreEndpoint {
   case users
   case followers
   case followings
   case posts
   
   var path: String {
      switch self {
      case .users:
         return "users"
      case .followers:
         return "followers"
      case .followings:
         return "followings"
      case .posts:
         return "posts"
      }
   }
}
