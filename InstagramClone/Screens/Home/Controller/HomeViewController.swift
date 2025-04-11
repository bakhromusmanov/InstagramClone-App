//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class HomeViewController: UIViewController {
   //MARK: - Properties
   
   //MARK: Subviews
   
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      updateColors()
   }
}

//MARK: - Appearance & Theming
private extension HomeViewController {
   func updateColors() {
      view.backgroundColor = ThemeManager.backgroundPrimaryColor
   }
}

//MARK: - Layout & Constraints
private extension HomeViewController {
   func setupViews() {
      
   }
   
   func setupConstraints() {
      
   }
}
