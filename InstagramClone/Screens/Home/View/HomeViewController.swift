//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class HomeViewController: UIViewController {
   
   //MARK: - Properties
   
   private var posts = [PostEntity]()
   
   //MARK: - Subviews
   
   private let topSeparatorView: UIView = {
      let view = UIView()
      view.backgroundColor = ThemeManager.colors.separatorLine
      return view
   }()
   
   private lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.minimumLineSpacing = Constants.cellToCellSpacing
      
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.showsVerticalScrollIndicator = false
      collectionView.alwaysBounceVertical = true
      collectionView.register(HomeCell.self, forCellWithReuseIdentifier: Constants.homeCell)
      
      return collectionView
   }()
   
   //MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      fetchFeedPosts()
      setupViews()
      setupConstraints()
      setupNavigationBar()
      updateColors()
   }
}

//MARK: - Public Methods

extension HomeViewController {
   func refreshData() {
      fetchFeedPosts()
   }
}

//MARK: - Private Methods

private extension HomeViewController {
   func setupNavigationBar() {
      navigationItem.title = Constants.navigationBarTitle
      navigationController?.navigationBar.backgroundColor = ThemeManager.colors.backgroundSecondary
      navigationItem.titleView?.tintColor = ThemeManager.colors.textPrimaryDark
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(
         title: Constants.logoutTitle,
         style: .done,
         target: self,
         action: #selector(logoutButtonPressed))
      navigationItem.leftBarButtonItem?.tintColor = ThemeManager.colors.textPrimaryDark
   }
}

//MARK: - Actions

@objc
private extension HomeViewController {
   func logoutButtonPressed() {
      AuthService.shared.logout()
      let loginVC = LoginViewController()
      guard let controller = tabBarController as? TabBarViewController else { return }
      loginVC.setDelegate(controller)
      let loginNav = UINavigationController(rootViewController: loginVC)
      loginNav.modalPresentationStyle = .fullScreen
      present(loginNav, animated: true)
   }
}

//MARK: - Networking

private extension HomeViewController {
   func fetchFeedPosts() {
      PostService.shared.fetchFeedPosts { [weak self] posts in
         guard let self = self else { return }
         self.posts = posts
         self.collectionView.reloadData()
      }
   }
}

//MARK: - Appearance & Theming

private extension HomeViewController {
   func updateColors() {
      view.backgroundColor = ThemeManager.colors.backgroundSecondary
   }
}

//MARK: - Layout & Constraints

private extension HomeViewController {
   func setupViews() {
      view.addSubview(topSeparatorView)
      view.addSubview(collectionView)
   }
   
   func setupConstraints() {
      topSeparatorView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.trailing.equalToSuperview()
         make.height.equalTo(Constants.separatorLineHeight)
      }
      
      collectionView.snp.makeConstraints { make in
         make.top.equalTo(topSeparatorView.snp.bottom)
         make.bottom.leading.trailing.equalToSuperview()
      }
   }
}

//MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return posts.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeCell, for: indexPath)
      
      guard let cell = cell as? HomeCell else { return cell }
      
      cell.setMediaHeight(view.bounds.width)
      cell.configure(with: posts[indexPath.row])
      return cell
   }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let cellWidth = collectionView.bounds.width
      let mediaHeight = cellWidth
      
      let cellHeight = HomeCell.baseContentHeight + mediaHeight
      return CGSize(width: cellWidth, height: cellHeight)
   }
}

//MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
   
}

//MARK: - Constants

private extension HomeViewController {
   enum Constants {
      //Texts
      static let navigationBarTitle = "Feed"
      static let homeCell = "HomeCell"
      static let logoutTitle = "Logout"
      
      static let defaultNumberOfItems = 6
      
      static let cellToCellSpacing: CGFloat = ThemeManager.spacings.spacingS
      static let separatorLineHeight: CGFloat = ThemeManager.sizes.separatorLineHeight
   }
}
