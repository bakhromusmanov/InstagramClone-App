//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 18/04/25.
//

import Foundation

struct LoginViewModel: EmailValidatable, PasswordValidatable {
   var email: String = ""
   var password: String = ""
   
   var isValid: Bool {
      return isEmailValid && isPasswordValid
   }
}

