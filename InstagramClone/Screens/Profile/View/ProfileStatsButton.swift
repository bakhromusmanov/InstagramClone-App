//
//  ProfileStatsButton.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 02/05/25.
//

import Foundation
import UIKit

final class ProfileStatsButton: UIButton {
   
   //MARK: - Subviews
   
   private let countLabel: UILabel = {
      let label = UILabel()
      label.textColor = ThemeManager.textPrimaryColor
      label.font = ThemeManager.titleBold
      return label
   }()
   
   private let label: UILabel = {
      let label = UILabel()
      label.textColor = ThemeManager.textSecondaryColor
      label.font = ThemeManager.titleRegular
      return label
   }()
   
   //MARK: - Initialization
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupViews()
      setupConstraints()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Public Functions
   
   func setupButton(title: String, count: String) {
      label.text = title
      countLabel.text = count
   }
}

//MARK: Layout & Constraints

private extension ProfileStatsButton {
   
   func setupViews() {
      addSubview(countLabel)
      addSubview(label)
   }
   
   func setupConstraints() {
      
      countLabel.snp.makeConstraints { make in
         make.top.equalToSuperview()
         make.centerX.equalToSuperview()
      }
      
      label.snp.makeConstraints { make in
         make.top.equalTo(countLabel.snp.bottom).offset(Constants.labelToLabelSpacing)
         make.bottom.equalToSuperview()
         make.centerX.equalToSuperview()
      }
   }
   
}

//MARK: - Constants

private extension ProfileStatsButton {
   enum Constants {
      static let labelToLabelSpacing: CGFloat = 4
   }
}

