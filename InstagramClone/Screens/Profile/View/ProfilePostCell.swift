//
//  ProfilePostCell.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 02/05/25.
//

import Foundation
import UIKit

final class ProfilePostCell: UICollectionViewCell {
   
   //MARK: - Subviews
   
   private lazy var postImageView: UIImageView = {
      let imageView = UIImageView(image: UIImage(named: Constants.postImageName))
      imageView.contentMode = .scaleAspectFill
      return imageView
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
}

//MARK: - Layout & Constraints

private extension ProfilePostCell {
   func setupViews() {
      contentView.addSubview(postImageView)
   }
   
   func setupConstraints() {
      postImageView.snp.makeConstraints { make in
         make.edges.equalToSuperview()
      }
   }
}

//MARK: - Constants

private extension ProfilePostCell {
   enum Constants {
      
      //Icons
      static let postImageName = "placeholder"
   }
}
