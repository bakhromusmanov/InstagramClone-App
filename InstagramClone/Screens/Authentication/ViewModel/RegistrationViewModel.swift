//
//  RegistrationViewModel.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 21/04/25.
//

import Foundation

struct RegistrationViewModel: EmailValidatable, PasswordValidatable {
   var email: String = ""
   var password: String = ""
   var fullName: String = ""
   var username: String = ""
   
   var isValid: Bool {
      return isEmailValid && isPasswordValid && !fullName.isEmpty && !username.isEmpty
   }
}
