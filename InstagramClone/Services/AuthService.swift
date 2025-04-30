//
//  AuthService.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 29/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct AuthService {
   
   typealias AuthDataResultCallback = (AuthDataResult?, Error?) -> Void
   
   static var isUserLoggedOut: Bool {
      return Auth.auth().currentUser == nil
   }
   
   static func logout() {
      do {
         try Auth.auth().signOut()
      } catch {
         print("DEBUG: Error while signing out")
      }
   }
   
   static func login(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
      Auth.auth().signIn(withEmail: email, password: password, completion: completion)
   }
   
   static func register(user: AuthEntity, completion: @escaping (Error?) -> Void) {
      
      var user = user
      
      Auth.auth().createUser(withEmail: user.email, password: user.password, completion: { result, error in
         if let error {
            completion(error)
            return
         }
         
         guard let uid = result?.user.uid else {
            print("DEBUG: Error while generating UID")
            return
         }
         
         user.userId = uid
         let userPath = DatabaseEndpoint.user(uid: uid).path
         let ref = Database.database().reference().child(userPath)
         
         ref.setValue(user.toDictionary()) { error, _ in
            completion(error)
            return
         }
      })
      
   }
   
}

