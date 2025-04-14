//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class HomeViewController: UIViewController {
   //MARK: - Properties
   
   //MARK: Subviews
   private lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.minimumLineSpacing = Constants.cellToCellSpacing
      
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
      navigationBar(isHidden: true)
   }
   
   //MARK: - Private Functions
   private func navigationBar(isHidden: Bool) {
      navigationController?.navigationBar.isHidden = isHidden
   }
   
   private func calculateCellHeight() -> CGFloat {
      let avatarSectionHeight = HomeCell.Constants.avatarImageViewSize + 2 * HomeCell.Constants.containerEdgesInset
      let mediaHeight = view.bounds.width
      let actionsSectionHeight = ThemeManager.actionButtonSize + 2 * HomeCell.Constants.containerEdgesInset
      let footerSectionHeight =
      ThemeManager.labelHeight(font: ThemeManager.subtitle) +
      ThemeManager.labelHeight(font: ThemeManager.body) +
      ThemeManager.labelHeight(font: ThemeManager.caption) +
      2 * HomeCell.Constants.containerEdgesInset
      
      let height = avatarSectionHeight + mediaHeight + actionsSectionHeight + footerSectionHeight
      print(height)
      return height
   }
}

//MARK: - Helpers
private extension HomeViewController {
   
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 5
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

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let width = view.bounds.width
      let height = calculateCellHeight()
      return CGSize(width: width, height: height)
   }
}

//MARK: - Appearance & Theming
private extension HomeViewController {
   func updateColors() {
      view.backgroundColor = ThemeManager.backgroundPrimaryColor
   }
}

//MARK: - Layout & Constraints
private extension HomeViewController {
   func setupViews() {
      view.addSubview(collectionView)
   }
   
   func setupConstraints() {
      collectionView.snp.makeConstraints { make in
         make.leading.trailing.equalToSuperview()
         make.top.bottom.equalTo(view.safeAreaLayoutGuide)
      }
   }
}

//MARK: - Constants
private extension HomeViewController {
   enum Constants {
      static let homeCell = "HomeCell"
      static let cellToCellSpacing: CGFloat = 8
   }
}
