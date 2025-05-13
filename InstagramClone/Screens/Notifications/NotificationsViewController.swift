//
//  NotificationViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class NotificationsViewController: UIViewController {
   //MARK: - Properties
   
   //MARK: Subviews
   
   //MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      updateColors()
   }
}

//MARK: - Appearance & Theming
private extension NotificationsViewController {
   func updateColors() {
      view.backgroundColor = ThemeManager.colors.backgroundPrimary
   }
}

//MARK: - Layout & Constraints
private extension NotificationsViewController {
   func setupViews() {
      
   }
   
   func setupConstraints() {
      
   }
}
