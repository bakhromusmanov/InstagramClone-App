//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 18/04/25.
//

import Foundation

struct LoginViewModel {
   var email: String?
   var password: String?
   
   var isValid: Bool {
      guard let email = email, let password = password else { return false }
      return !email.isEmpty && !password.isEmpty
   }
}

struct RegistrationViewModel {
   var email: String?
   var password: String?
   var fullName: String?
   var username: String?
   
   var isValid: Bool {
      guard let email = email, let password = password, let fullName = fullName, let username = username else { return false }
      return !email.isEmpty && !password.isEmpty && !fullName.isEmpty && !username.isEmpty
   }
}
