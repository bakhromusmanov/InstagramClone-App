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
      label.textColor = ThemeManager.colors.textPrimary
      label.font = ThemeManager.fonts.bodyMediumBold
      return label
   }()
   
   private let label: UILabel = {
      let label = UILabel()
      label.textColor = ThemeManager.colors.textSecondary
      label.font = ThemeManager.fonts.bodyMediumRegular
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
   
   func setupStats(title: String, value: Int) {
      label.text = title
      countLabel.text = "\(value)"
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

