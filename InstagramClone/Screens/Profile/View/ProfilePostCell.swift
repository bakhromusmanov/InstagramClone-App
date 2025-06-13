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

//MARK: - Public Methods

extension ProfilePostCell {
   func configure(with imageUrl: String?) {
      fetchPostImage(from: imageUrl)
   }
}

//MARK: - Networking

private extension ProfilePostCell {
   func fetchPostImage(from urlString: String?) {
      guard let urlString = urlString, let url = URL(string: urlString) else { return }
      ImageDownloaderService.shared.loadImage(from: url) { [weak self] image in
         guard let self = self else { return }
         self.postImageView.image = image
      }
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
