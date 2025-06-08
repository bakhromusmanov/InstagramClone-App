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
   
   func fetchUser(with userUid: String? = nil, completion: @escaping (UserEntity) -> Void) {
      
      let emptyUser = UserEntity()
      
      guard let uid = userUid ?? Auth.auth().currentUser?.uid else {
          print(UserServiceError.nilUserUid.localizedDescription)
          completion(emptyUser)
          return
      }
      
      COLLECTION_USERS.document(uid).getDocument { snapshot, error in
         if let error = error {
            print(UserServiceError.firestoreError(error).localizedDescription)
            completion(emptyUser)
            return
         }
         
         guard let snapshot = snapshot else {
            print(UserServiceError.nilSnapshot.localizedDescription)
            completion(emptyUser)
            return
         }
         
         if let user = snapshot.decode(as: UserEntity.self) {
            print(UserServiceSuccess.fetchUser)
            completion(user)
         }
      }
   }
   
   //MARK: Fetch Users
   
   func fetchUsers(completion: @escaping ([UserEntity]) -> Void) {
      let emptyUsers = [UserEntity()]
      COLLECTION_USERS.getDocuments { snapshot, error in
         if let error = error {
            print(UserServiceError.firestoreError(error).localizedDescription)
            completion(emptyUsers)
            return
         }
         
         guard let documents = snapshot?.documents else {
            print(UserServiceError.nilSnapshot.localizedDescription)
            completion(emptyUsers)
            return
         }
         
         let users = documents.compactMap { document in
            document.decode(as: UserEntity.self)
         }
         
         print(UserServiceSuccess.fetchUsers)
         completion(users)
      }
   }
   
   //MARK: Check is Followed
   
   func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void) {
      guard let currentUserUid = AuthService.shared.currentUserUid else {
         print(UserServiceError.nilUserUid.localizedDescription)
         completion(false)
         return
      }
      
      COLLECTION_USERS.document(currentUserUid).collection(COLLECTION_FOLLOWINGS).document(uid).getDocument { snapshot, error in
         
         if let error = error {
            print(UserServiceError.firestoreError(error).localizedDescription)
            completion(false)
            return
         }
         
         guard let isFollowed = snapshot?.exists else {
            print(UserServiceError.nilSnapshot)
            completion(false)
            return
         }
         print(UserServiceSuccess.checkIfUserFollowed)
         completion(isFollowed)
      }
   }
   
   //MARK: Follow User
   
   func followUser(with targetUserUid: String, completion: @escaping (Error?) -> Void) {
      guard let currentUserUid = AuthService.shared.currentUserUid else {
         print(UserServiceError.nilUserUid.localizedDescription)
         completion(UserServiceError.nilUserUid)
         return
      }
      
      let currentUserRef = COLLECTION_USERS.document(currentUserUid)
      let targetUserRef = COLLECTION_USERS.document(targetUserUid)
      
      currentUserRef.collection(COLLECTION_FOLLOWINGS).document(targetUserUid).setData([:]) { error in
         
         if let error = error {
            print(
               UserServiceError.followFailed(error).localizedDescription
            )
            completion(error)
            return
         }
         
         targetUserRef.collection(COLLECTION_FOLLOWERS).document(currentUserUid).setData([:]) { error in
            
            if let error = error {
               print(UserServiceError.followFailed(error).localizedDescription)
               completion(error)
               return
            }
            
            currentUserRef.updateData([Constants.followingsCount : FieldValue.increment(Int64(1))])
            
            targetUserRef.updateData([Constants.followersCount : FieldValue.increment(Int64(1))])
            
            completion(nil)
            print(UserServiceSuccess.followUser)
         }
      }
   }
   
   //MARK: Unfollow User
   
   func unfollowUser(with targetUserUid: String, completion: @escaping (Error?) -> Void) {
      guard let currentUserUid = AuthService.shared.currentUserUid else {
         print(UserServiceError.nilUserUid.localizedDescription)
         completion(UserServiceError.nilUserUid)
         return
      }
      
      let currentUserRef = COLLECTION_USERS.document(currentUserUid)
      let targetUserRef = COLLECTION_USERS.document(targetUserUid)
      
      currentUserRef.collection(COLLECTION_FOLLOWINGS).document(targetUserUid).delete { error in
         
         if let error = error {
            print(UserServiceError.unfollowFailed(error).localizedDescription)
            completion(UserServiceError.unfollowFailed(error))
            return
         }
         
         targetUserRef.collection(COLLECTION_FOLLOWERS).document(currentUserUid).delete { error in
            
            if let error = error {
               print(UserServiceError.unfollowFailed(error).localizedDescription)
               completion(UserServiceError.unfollowFailed(error))
               return
            }
            
            currentUserRef.updateData([Constants.followingsCount : FieldValue.increment(Int64(-1))])
            
            targetUserRef.updateData([Constants.followersCount : FieldValue.increment(Int64(-1))])
            
            completion(nil)
            print(UserServiceSuccess.unfollowUser)
         }
      }
   }
   
}

//MARK: - UserServiceError

private enum UserServiceError: Error {
   case nilUserUid
   case firestoreError(Error)
   case nilSnapshot
   case followFailed(Error)
   case unfollowFailed(Error)
   case unknownError
   
   var localizedDescription: String {
      switch self {
      case .nilUserUid:
         return "DEBUG: Current user UID is nil."
      case .firestoreError(let error):
         return "DEBUG: Firestore error: \(error.localizedDescription)"
      case .nilSnapshot:
         return "DEBUG: Snapshot is nil."
      case .followFailed(let error):
         return "DEBUG: Failed to follow user: \(error.localizedDescription)"
      case .unfollowFailed(let error):
         return "DEBUG: Failed to unfollow user: \(error.localizedDescription)"
      case .unknownError:
         return "DEBUG: An unknown error occurred."
      }
   }
}

//MARK: - UserServiceSuccess

private enum UserServiceSuccess {
   static let fetchUser = "DEBUG: SUCCESS to fetch user!"
   static let fetchUsers = "DEBUG: SUCCESS to fetch users!"
   static let checkIfUserFollowed = "DEBUG: SUCCESS to check if user is followed!"
   static let followUser = "DEBUG: SUCCESS to follow user!"
   static let unfollowUser = "DEBUG: SUCCESS to unfollow user!"
   static let userStats = "DEBUG: SUCCESS to fetch user stats!"
}

//MARK: - Constants

private extension UserService {
   enum Constants {
      static let followingsCount = "followingsCount"
      static let followersCount = "followersCount"
   }
}
