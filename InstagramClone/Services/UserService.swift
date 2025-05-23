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
   
   //MARK: fetchUser
   
   func fetchUser(completion: @escaping (UserEntity) -> Void) {
      guard let uid = Auth.auth().currentUser?.uid else {
         print("DEBUG: Couldn't get current user UID")
         return
      }
      
      COLLECTION_USERS.document(uid).getDocument { snapshot, error in
         if let error = error {
            print("DEBUG: Error fetching user: \(error.localizedDescription)")
            return
         }
         
         guard let snapshot = snapshot, snapshot.exists else {
            print("DEBUG: Snapshot is nil or user document does not exist")
            return
         }
         
         if let user = snapshot.decode(as: UserEntity.self) {
            completion(user)
         }
      }
   }
   
   //MARK: fetchUsers
   
   func fetchUsers(completion: @escaping ([UserEntity]) -> Void) {
      
      
      COLLECTION_USERS.getDocuments { snapshot, error in
         if let error = error {
            print("DEBUG: Error fetching user: \(error.localizedDescription)")
            return
         }
         
         guard let documents = snapshot?.documents else {
            print("DEBUG: Documents do not exist")
            return
         }
         
         let users = documents.compactMap { document in
            document.decode(as: UserEntity.self)
         }
         
         completion(users)
      }
   }
}



