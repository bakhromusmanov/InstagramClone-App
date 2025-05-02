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
   
   private lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.minimumLineSpacing = Constants.cellToCellSpacing
      layout.minimumInteritemSpacing = Constants.cellToCellSpacing
      print(layout.sectionHeadersPinToVisibleBounds)
      
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.register(ProfilePostCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
      collectionView.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.headerIdentifier)
      return collectionView
   }()
   
   //MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      setupConstraints()
      updateColors()
      collectionView.backgroundColor = .purple
   }
}

//MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return Constants.numberOfItems
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)
      
      guard let cell = cell as? ProfilePostCell else { return cell }
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.headerIdentifier, for: indexPath)
      
      guard let headerView = headerView as? ProfileHeaderView else { return headerView }
      return headerView
   }
}

//MARK: - UICollectionViewDelegate

extension ProfileViewController: UICollectionViewDelegate {
   
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let collectionWidth = collectionView.frame.width - (Constants.numberOfItemsInRow - 1) * Constants.cellToCellSpacing
      let itemWidth = collectionWidth / Constants.numberOfItemsInRow

      return CGSize(width: itemWidth, height: itemWidth)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      
      return CGSize(width: collectionView.frame.width, height: 240)
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
      view.addSubview(collectionView)
   }
   
   func setupConstraints() {
      collectionView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.trailing.bottom.equalToSuperview()
      }
   }
}

//MARK: - Constants

private extension ProfileViewController {
   enum Constants {
      
      //Namings
      static let cellIdentifier = "ProfileImageCell"
      static let headerIdentifier = "ProfileHeaderView"
      
      //Spacings
      static let cellToCellSpacing: CGFloat = 2
      
      //Sizes
      static let profileHeaderHeight: CGFloat = 240
      
      //Default
      static let numberOfItems = 6
      static let numberOfItemsInRow: CGFloat = 3
   }
   
}
