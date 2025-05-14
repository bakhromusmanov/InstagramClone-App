//
//  ProfileViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class ProfileViewController: UIViewController {
   
   //MARK: - Properties
   
   private var user: UserEntity
   
   //MARK: Subviews
   
   private let topSeparatorView: UIView = {
      let view = UIView()
      view.backgroundColor = ThemeManager.colors.textSecondary
      return view
   }()
   
   private lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.minimumLineSpacing = Constants.gridSpacing
      layout.minimumInteritemSpacing = Constants.gridSpacing
      
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.alwaysBounceVertical = true
      collectionView.register(ProfilePostCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
      collectionView.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.headerIdentifier)
      return collectionView
   }()
   
   //MARK: - Lifecycle
   
   init(user: UserEntity) {
      self.user = user
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setUpNavigationBar()
      setupViews()
      setupConstraints()
      updateColors()
   }
}

//MARK: - Public Functions

extension ProfileViewController {

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
      let viewModel = ProfileHeaderViewModel(user: user)
      headerView.setViewModel(viewModel)
      return headerView
   }
}

//MARK: - UICollectionViewDelegate

extension ProfileViewController: UICollectionViewDelegate {
   
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let collectionWidth = collectionView.frame.width - (Constants.numberOfItemsInRow - 1) * Constants.gridSpacing
      let itemWidth = collectionWidth / Constants.numberOfItemsInRow
      
      return CGSize(width: itemWidth, height: itemWidth)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      let height = ProfileHeaderView.calculateHeight()
      return CGSize(width: collectionView.frame.width, height: height)
   }
   
}

//MARK: - Appearance & Theming

private extension ProfileViewController {
   
   func setUpNavigationBar() {
      navigationController?.navigationBar.titleTextAttributes = [
         .foregroundColor : ThemeManager.colors.textPrimary]
      navigationItem.title = user.username
   }
   
   func updateColors() {
      view.backgroundColor = ThemeManager.colors.backgroundPrimary
      navigationController?.navigationBar.backgroundColor = ThemeManager.colors.backgroundSecondary
   }
}

//MARK: - Layout & Constraints

private extension ProfileViewController {
   func setupViews() {
      view.addSubview(topSeparatorView)
      view.addSubview(collectionView)
   }
   
   func setupConstraints() {
      topSeparatorView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.trailing.equalToSuperview()
         make.height.equalTo(ThemeManager.spacings.separatorLineHeight)
      }
      
      collectionView.snp.makeConstraints { make in
         make.top.equalTo(topSeparatorView.snp.bottom)
         make.leading.trailing.bottom.equalToSuperview()
      }
   }
}

//MARK: - Constants

private extension ProfileViewController {
   enum Constants {
      
      //Texts
      static let cellIdentifier = "ProfileImageCell"
      static let headerIdentifier = "ProfileHeaderView"
      
      //Spacings
      static let gridSpacing: CGFloat = 2
      
      //Sizes
      static let profileHeaderHeight: CGFloat = 240
      
      //Default
      static let numberOfItems = 6
      static let numberOfItemsInRow: CGFloat = 3
   }
   
}
