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
   
   //MARK: - Logout
   
   func logout() {
      do {
         try Auth.auth().signOut()
         print(AuthServiceSuccess.logout)
      } catch {
         print(AuthServiceError.firestoreError(error).localizedDescription)
      }
   }
   
   //MARK: - Login
   
   func login(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
      Auth.auth().signIn(withEmail: email, password: password, completion: completion)
      print(AuthServiceSuccess.loginUser)
   }
   
   //MARK: - Register
   
   func register(authEntity: AuthEntity, completion: @escaping (Error?) -> Void) {
      
      Auth.auth().createUser(withEmail: authEntity.email, password: authEntity.password) { result, error in
         if let error {
            print(AuthServiceError.firestoreError(error).localizedDescription)
            completion(AuthServiceError.firestoreError(error))
            return
         }
         
         guard let uid = result?.user.uid else {
            print(AuthServiceError.nilUserUID.localizedDescription)
            completion(AuthServiceError.nilUserUID)
            return
         }
         
         let user = UserEntity(email: authEntity.email, fullName: authEntity.fullName, username: authEntity.username, userId: uid, profileImageURL: authEntity.profileImageURL)
         
         guard let data = try? Firestore.Encoder().encode(user) else {
            print(AuthServiceError.encodingUserFailed.localizedDescription)
            completion(AuthServiceError.encodingUserFailed)
            return
         }
         
         COLLECTION_USERS.document(uid).setData(data, completion: completion)
         print(AuthServiceSuccess.registerUser)
      }
   }
}

//MARK: - AuthServiceError

private enum AuthServiceError: Error {
   case nilUserUID
   case firestoreError(Error)
   case encodingUserFailed
   case unknownError
   
   var localizedDescription: String {
      switch self {
      case .nilUserUID:
         return "DEBUG: Current user UID is nil."
      case .firestoreError(let error):
         return "DEBUG: Firestore error: \(error.localizedDescription)"
      case .encodingUserFailed:
         return "DEBUG: Failed to encode user."
      case .unknownError:
         return "DEBUG: An unknown error occurred."
      }
   }
}

//MARK: - AuthServiceSuccess

private enum AuthServiceSuccess {
   static let registerUser = "DEBUG: SUCCESS to register user!"
   static let loginUser = "DEBUG: SUCCESS to login user!"
   static let logout = "DEBUG: SUCCESS to logout user!"
}

