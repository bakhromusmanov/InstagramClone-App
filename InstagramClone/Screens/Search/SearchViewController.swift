//
//  SearchViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class SearchViewController: UIViewController {
   //MARK: - Properties
   
   //MARK: Subviews
   
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      updateColors()
   }
}

//MARK: - Appearance & Theming
private extension SearchViewController {
   func updateColors() {
      view.backgroundColor = ThemeManager.backgroundPrimaryColor
   }
}

//MARK: - Layout & Constraints
private extension SearchViewController {
   func setupViews() {
      
   }
   
   func setupConstraints() {
      
   }
}
