//
//  ImageSelectorController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class ImageSelectorController: UIViewController {
   //MARK: - Properties
   
   //MARK: Subviews
   
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      updateColors()
   }
}

//MARK: - Appearance & Theming
private extension ImageSelectorController {
   func updateColors() {
      view.backgroundColor = ThemeManager.colors.backgroundPrimary
   }
}

//MARK: - Layout & Constraints
private extension ImageSelectorController {
   func setupViews() {
      
   }
   
   func setupConstraints() {
      
   }
}
