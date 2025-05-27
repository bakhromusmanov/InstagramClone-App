//
//  AuthService.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 29/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AuthDelegate: AnyObject {
   func authDidComplete()
}

final class AuthService {
   
   static let shared = AuthService()
   private init() { }
   
   //MARK: - Properties
   
   typealias AuthDataResultCallback = (AuthDataResult?, Error?) -> Void
   
   var isUserLoggedOut: Bool {
      return Auth.auth().currentUser == nil
   }
   
   var currentUserUid: String? {
      return Auth.auth().currentUser?.uid
   }
   
   //MARK: Public Methods
   
   func logout() {
      do {
         try Auth.auth().signOut()
      } catch {
         print("DEBUG: Error while signing out")
      }
   }
   
   func login(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
      Auth.auth().signIn(withEmail: email, password: password, completion: completion)
   }
   
   func register(authEntity: AuthEntity, completion: @escaping (Error?) -> Void) {
      
      Auth.auth().createUser(withEmail: authEntity.email, password: authEntity.password) { result, error in
         if let error {
            completion(error)
            return
         }
         
         guard let uid = result?.user.uid else {
            print("DEBUG: Error while generating UID")
            return
         }
         
         let user = UserEntity(email: authEntity.email, fullName: authEntity.fullName, username: authEntity.username, userId: uid, profileImageURL: authEntity.profileImageURL)
         
         guard let data = try? Firestore.Encoder().encode(user) else {
            print("DEBUG: Error while encoding users auth data.")
            return
         }
         
         COLLECTION_USERS.document(uid).setData(data, completion: completion)
      }
   }
   
}

