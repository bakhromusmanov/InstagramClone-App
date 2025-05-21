//
//  AuthService.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 29/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
   
   static let shared = AuthService()
   private init() { }
   
   //MARK: - Properties
   
   typealias AuthDataResultCallback = (AuthDataResult?, Error?) -> Void
   
   var isUserLoggedOut: Bool {
      return Auth.auth().currentUser == nil
   }
   
   let ref = Firestore.firestore()
   
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
   
   func register(user: AuthEntity, completion: @escaping (Error?) -> Void) {
      
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
         
         do {
            let data = try Firestore.Encoder().encode(user)
            let path = FirestoreEndpoint.users.path
            Firestore.firestore().collection(path).document(uid).setData(data) { error in
               completion(error)
               return
            }
         } catch {
            completion(error)
            return
         }
      })
   }
   
}

