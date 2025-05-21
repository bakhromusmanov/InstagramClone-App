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
         print("DEBUG: Couldn't get current user UID")
         return
      }
      
      let usersPath = FirestoreEndpoint.users.path
      let usersCollection = Firestore.firestore().collection(usersPath)
      
      usersCollection.document(uid).getDocument { snapshot, error in
         if let error = error {
            print("DEBUG: Error fetching user: \(error.localizedDescription)")
            return
         }
         
         guard let snapshot = snapshot, snapshot.exists else {
            print("DEBUG: Snapshot is nil or user document does not exist")
            return
         }
         
         do {
            let user = try snapshot.data(as: UserEntity.self)
            completion(user)
            return
         } catch {
            print("DEBUG: Failed to decode UserEntity: \(error.localizedDescription)")
            return
         }
      }
   }
   
   func fetchUsers(completion: @escaping ([UserEntity]) -> Void) {
      
      let usersPath = FirestoreEndpoint.users.path
      let usersCollection = Firestore.firestore().collection(usersPath)
      
      usersCollection.getDocuments { snapshot, error in
         if let error = error {
            print("DEBUG: Error fetching user: \(error.localizedDescription)")
            return
         }
         
         guard let documents = snapshot?.documents else {
            print("DEBUG: Documents do not exist")
            return
         }
         
         let users = documents.compactMap { document in
            do {
               return try document.data(as: UserEntity.self)
            } catch {
               print("Error decoding document \(document.documentID): \(error.localizedDescription)")
               return nil
            }
         }
         
         completion(users)
      }
   }
}


