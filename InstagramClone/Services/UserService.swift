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
   static func fetchUser(completion: @escaping (UserEntity?) -> Void) {
      
      guard let uid = Auth.auth().currentUser?.uid else { return }
      
      let path = UserEndpoint.user(uid: uid).path
      let ref = Database.database().reference().child(path)
      
      ref.getData { error, snapshot in
         
         if error != nil {
            completion(nil)
            return
         }
         
         if let snapshot, let value = snapshot.value {
            do {
               let data = try JSONSerialization.data(withJSONObject: value)
               let user: UserEntity = try JSONDecoder().decode(UserEntity.self, from: data)
               
               completion(user)
               return
               
            } catch {
               completion(nil)
               return
            }
         }
      }
      
   }
}
