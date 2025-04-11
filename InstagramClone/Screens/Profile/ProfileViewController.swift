//
//  ProfileViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class ProfileViewController: UIViewController {
   //MARK: - Properties
   
   //MARK: Subviews
   
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      updateColors()
   }
   
}

//MARK: - Appearance & Theming
private extension ProfileViewController {
   func updateColors() {
      view.backgroundColor = ThemeManager.backgroundPrimaryColor
   }
}

//MARK: - Layout & Constraints
private extension ProfileViewController {
   func setupViews() {
      
   }
   
   func setupConstraints() {
      
   }
}
