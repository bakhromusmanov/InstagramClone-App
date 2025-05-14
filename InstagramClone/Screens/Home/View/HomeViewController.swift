//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class HomeViewController: UIViewController {
   
   //MARK: Subviews
   
   private let topSeparatorView: UIView = {
      let view = UIView()
      view.backgroundColor = ThemeManager.colors.textSecondary
      return view
   }()
   
   private lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.minimumLineSpacing = Constants.spacingS
      layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
      
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.showsVerticalScrollIndicator = false
      collectionView.register(HomeCell.self, forCellWithReuseIdentifier: Constants.homeCell)
      
      return collectionView
   }()
   
   //MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      setupConstraints()
      updateColors()
      setUpNavigationBar()
   }
   
   //MARK: - Private Functions
   
   
   
   //MARK: - Actions
   
   @objc private func logoutButtonPressed() {
      AuthService.logout()
      let loginVC = LoginViewController()
      guard let controller = tabBarController as? TabBarViewController else { return }
      loginVC.setDelegate(controller)
      let loginNav = UINavigationController(rootViewController: loginVC)
      loginNav.modalPresentationStyle = .fullScreen
      present(loginNav, animated: true)
   }
}

//MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return Constants.defaultNumberOfItems
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeCell, for: indexPath)
      
      guard let cell = cell as? HomeCell else { return cell }
      
      return cell
   }
}

//MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
   
}

//MARK: - Appearance & Theming

private extension HomeViewController {
   
   func setUpNavigationBar() {
      navigationItem.leftBarButtonItem = UIBarButtonItem(
         title: Constants.logoutTitle,
         style: .done,
         target: self,
         action: #selector(logoutButtonPressed))
      navigationItem.leftBarButtonItem?.tintColor = ThemeManager.colors.textPrimary
   }
   
   func updateColors() {
      view.backgroundColor = ThemeManager.colors.backgroundSecondary
      navigationController?.navigationBar.backgroundColor = ThemeManager.colors.backgroundSecondary
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
         make.height.equalTo(ThemeManager.spacings.separatorLineHeight)
      }
      
      collectionView.snp.makeConstraints { make in
         make.top.equalTo(topSeparatorView.snp.bottom)
         make.bottom.leading.trailing.equalToSuperview()
      }
   }
}

//MARK: - Constants

private extension HomeViewController {
   enum Constants {
      static let homeCell = "HomeCell"
      static let logoutTitle = "Logout"
      static let spacingS: CGFloat = 8
      static let defaultNumberOfItems = 6
   }
}
