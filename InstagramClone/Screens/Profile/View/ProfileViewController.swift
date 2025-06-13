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
   private var posts = [PostEntity]()
   
   //MARK: Subviews
   
   private let topSeparatorView: UIView = {
      let view = UIView()
      view.backgroundColor = ThemeManager.colors.separatorLine
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
      fetchUserPosts()
      setupViews()
      setupConstraints()
      setupNavigationBar()
      updateColors()
   }
}

//MARK: - Public Functions

extension ProfileViewController {
   func updateUserStats(_ user: UserEntity) {
      self.user = user
      collectionView.reloadData()
   }
   
   func updateUserPosts(_ user: UserEntity) {
      self.user = user
      fetchUserPosts()
   }
}

//MARK: - Private Functions

private extension ProfileViewController {
   func setupNavigationBar() {
      navigationBar(isHidden: false)
      navigationController?.navigationBar.tintColor = ThemeManager.colors.textPrimaryDark
      navigationController?.navigationBar.backgroundColor = ThemeManager.colors.backgroundSecondary
      navigationItem.title = user.username
      if !isFirstViewController {
         navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.backButtonImageName),
            style: .plain,
            target: self,
            action: #selector(backButtonPressed)
         )
      }
   }
}

//MARK: - Actions

@objc
private extension ProfileViewController {
   func backButtonPressed() {
      navigationController?.popViewController(animated: true)
      self.navigationBar(isHidden: true)
   }
}

//MARK: - Networking

private extension ProfileViewController {
   func fetchUserPosts() {
      PostService.shared.fetchUserPosts(for: user.userId) { [weak self] posts in
         guard let self = self else { return }
         self.posts = posts
         self.collectionView.reloadData()
      }
   }
}

//MARK: - Appearance & Theming

private extension ProfileViewController {
   func updateColors() {
      collectionView.backgroundColor = ThemeManager.colors.backgroundPrimary
      view.backgroundColor = ThemeManager.colors.backgroundSecondary
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
         make.height.equalTo(ThemeManager.sizes.separatorLineHeight)
      }
      
      collectionView.snp.makeConstraints { make in
         make.top.equalTo(topSeparatorView.snp.bottom)
         make.leading.trailing.bottom.equalToSuperview()
      }
   }
}

//MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return posts.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)
      
      guard let cell = cell as? ProfilePostCell else { return cell }
      let post = posts[indexPath.row]
      cell.configure(with: post.postImageUrl)
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.headerIdentifier, for: indexPath)
      
      guard let headerView = headerView as? ProfileHeaderView else { return headerView }
      
      headerView.configure(with: user)
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

//MARK: - Constants

private extension ProfileViewController {
   enum Constants {
      
      //Texts
      static let cellIdentifier = "ProfileImageCell"
      static let headerIdentifier = "ProfileHeaderView"
      static let backButtonImageName = "chevron.left"
      
      //Spacings
      static let gridSpacing: CGFloat = 1
      
      //Sizes
      static let profileHeaderHeight: CGFloat = 240
      
      //Default
      static let numberOfItems = 6
      static let numberOfItemsInRow: CGFloat = 3
   }
   
}
