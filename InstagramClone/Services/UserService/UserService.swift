//
//  UserService.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 13/05/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class UserService {
   
   static let shared = UserService()
   private init() { }
   
   //MARK: Fetch User
   
   func fetchUser(completion: @escaping (UserEntity) -> Void) {
      guard let uid = Auth.auth().currentUser?.uid else {
         print(UserService.ErrorType.missingCurrentUserUid)
         return
      }
      
      COLLECTION_USERS.document(uid).getDocument { snapshot, error in
         if let error = error {
            print(UserService.ErrorType.snapshot + error.localizedDescription)
            return
         }
         
         guard let snapshot = snapshot else {
            print(UserService.ErrorType.snapshotNil)
            return
         }
         
         if let user = snapshot.decode(as: UserEntity.self) {
            print("DEBUG: SUCESS: fetchUser")
            completion(user)
         }
      }
   }
   
   //MARK: Fetch Users
   
   func fetchUsers(completion: @escaping ([UserEntity]) -> Void) {
      COLLECTION_USERS.getDocuments { snapshot, error in
         if let error = error {
            print(UserService.ErrorType.snapshot + error.localizedDescription)
            return
         }
         
         guard let documents = snapshot?.documents else {
            print(UserService.ErrorType.snapshotNil)
            return
         }
         
         let users = documents.compactMap { document in
            document.decode(as: UserEntity.self)
         }
         
         print("DEBUG: SUCESS: fetchUsers")
         completion(users)
      }
   }
   
   //MARK: Check is Followed
   
   func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void) {
      guard let currentUserUid = AuthService.shared.currentUserUid else {
         print(UserService.ErrorType.missingCurrentUserUid)
         return
      }
      
      COLLECTION_FOLLOWINGS.document(currentUserUid).collection(Constants.userFollowings).document(uid).getDocument { snapshot, error in
         
         if let error = error {
            print(UserService.ErrorType.snapshot + error.localizedDescription)
            return
         }
         
         guard let isFollowed = snapshot?.exists else {
            print(UserService.ErrorType.snapshotNil)
            return
         }
         
         print("DEBUG: SUCESS: checkIfUserIsFollowed")
         completion(isFollowed)
      }
   }
   
   //MARK: Follow User
   
   func followUser(with targetUserUid: String, completion: @escaping (Error?) -> Void) {
      guard let currentUserUid = AuthService.shared.currentUserUid else {
         print(UserService.ErrorType.missingCurrentUserUid)
         return
      }
      
      COLLECTION_FOLLOWINGS.document(currentUserUid).collection(Constants.userFollowings).document(targetUserUid).setData([:]) { error in
         
         if let error = error {
            print(UserService.ErrorType.followUser + error.localizedDescription)
            return
         }
         
         COLLECTION_FOLLOWERS.document(targetUserUid).collection(Constants.userFollowers).document(currentUserUid).setData([:], completion: completion)
         print("DEBUG: SUCESS: followUser")
      }
   }
   
   //MARK: Unfollow User
   
   func unfollowUser(with targetUserUid: String, completion: @escaping (Error?) -> Void) {
      guard let currentUserUid = AuthService.shared.currentUserUid else {
         print(UserService.ErrorType.missingCurrentUserUid)
         return
      }
      
      COLLECTION_FOLLOWINGS.document(currentUserUid).collection(Constants.userFollowings).document(targetUserUid).delete { error in
         
         if let error = error {
            print(UserService.ErrorType.unfollowUser + error.localizedDescription)
            return
         }
         
         COLLECTION_FOLLOWERS.document(targetUserUid).collection(Constants.userFollowers).document(currentUserUid).delete(completion: completion)
         print("DEBUG: SUCESS: unfollowUser")
      }
   }
   
   //MARK: Fetch Profile Stats
   
   func fetchProfileStats(for uid: String, completion: @escaping (UserStatsEntity) -> Void) {
      
      var followersCount = 0
      var followingsCount = 0
      
      COLLECTION_FOLLOWERS.document(uid).collection(Constants.userFollowers).getDocuments { snapshot, error in
         if let error = error {
            print(UserService.ErrorType.userStats + error.localizedDescription)
            return
         }
         
         if let snapshot = snapshot {
            followersCount = snapshot.documents.count
         }
         
         COLLECTION_FOLLOWINGS.document(uid).collection(Constants.userFollowings).getDocuments { snapshot, error in
            if let error = error {
               print(UserService.ErrorType.userStats + error.localizedDescription)
               return
            }
            
            if let snapshot = snapshot {
               followingsCount = snapshot.documents.count
            }
            
            let userStatsEntity = UserStatsEntity(followersCount: followersCount, followingsCount: followingsCount)
            print("DEBUG: SUCESS: fetchProfileStats")
            completion(userStatsEntity)
         }
      }
   }
}

//MARK: - UserService

extension UserService {
   enum ErrorType {
      static let missingCurrentUserUid = "DEBUG: Current user UID is nil."
      static let snapshot = "DEBUG: Firestore snapshot error: "
      static let snapshotNil = "DEBUG: Snapshot is nil."
      static let followUser = "DEBUG: Failed to follow user: "
      static let unfollowUser = "DEBUG: Failed to unfollow user: "
      static let userStats = "DEBUG: Failed to fetch user stats: "
   }
}

//MARK: - Constants

private extension UserService {
   enum Constants {
      static let userFollowers = "user_followers"
      static let userFollowings = "user_followings"
   }
}
