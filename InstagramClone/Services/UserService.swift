//
//  UserService.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 13/05/25.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

final class UserService {
   
   //MARK: Fetch User
   
   static func fetchUser(completion: @escaping (UserEntity) -> Void) {
      guard let uid = Auth.auth().currentUser?.uid else {
         print("DEBUG: Couldn't get current user UID")
         return
      }
      
      let path = UserEndpoint.user(uid: uid).path
      fetchFromFirebase(path: path, type: UserEntity.self, completion: completion)
   }
   
   static func fetchUsers(completion: @escaping ([UserEntity]) -> Void) {
      let path = UserEndpoint.users.path
      fetchFromFirebase(path: path, type: [String : UserEntity].self) { dict in
         let users = dict.map { $0.value }
         completion(users)
      }
   }
}

//MARK: - Private Functions

private extension UserService {
   
   static func fetchFromFirebase<T: Decodable>(path: String, type: T.Type, completion: @escaping (T) -> Void) {
      
      let ref = Database.database().reference().child(path)
      
      ref.getData { error, snapshot in
         guard error == nil else {
            print("DEBUG: Error getting data from path: \(path)")
            return
         }
         
         guard let snapshot, let value = snapshot.value else {
            print("DEBUG: Snapshot is nil at path: \(path)")
            return
         }
         
         do {
            let data = try JSONSerialization.data(withJSONObject: value)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            completion(decoded)
         } catch {
            print("DEBUG: Decoding error at path: \(path)")
         }
      }
   }
   
}
