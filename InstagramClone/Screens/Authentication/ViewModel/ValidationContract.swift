//
//  ValidationContract.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 21/04/25.
//

import Foundation

protocol EmailValidatable {
   var email: String { get set }
   var isEmailValid: Bool { get }
}

protocol PasswordValidatable {
   var password: String { get set }
   var isPasswordValid: Bool { get }
}

//MARK: - Default EmailValidatable

extension EmailValidatable {
   var isEmailValid: Bool {
      return email.contains("@") && email.contains(".")
   }
}

//MARK: - Default PasswordValidatable

extension PasswordValidatable {
   var isPasswordValid: Bool {
      return password.count >= SettingsManager.minPasswordLength
   }
}
