//
//  SearchViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

final class SearchViewController: UIViewController {
   
   //MARK: - Properties
   
   private var users = [UserEntity]() {
      didSet {
         updateView()
      }
   }
   
   private var searchedUsers = [UserEntity]()
   
   //MARK: - Subviews
   
   private lazy var searchBar: UISearchBar = {
      let searchBar = UISearchBar()
      searchBar.barTintColor = ThemeManager.colors.backgroundSecondary
      searchBar.keyboardType = .asciiCapable
      searchBar.returnKeyType = .search
      
      //Setup TextField
      searchBar.searchTextField.font = ThemeManager.fonts.bodyMediumMedium
      searchBar.searchTextField.textColor = ThemeManager.colors.textPrimaryDark
      searchBar.searchTextField.borderStyle = .roundedRect
      searchBar.searchTextField.placeholder = Constants.searchPlaceholder
      searchBar.searchTextField.layer.cornerRadius = Constants.searchBarCornerRadius
      searchBar.searchTextField.clipsToBounds = true
      
      searchBar.delegate = self
      return searchBar
   }()
   
   private lazy var tableView: UITableView = {
      let tableView = UITableView(frame: .zero, style: .plain)
      tableView.separatorStyle = .singleLine
      
      tableView.dataSource = self
      tableView.delegate = self
      tableView.register(SearchViewCell.self, forCellReuseIdentifier: Constants.searchCellIdentifier)
      return tableView
   }()
   
   //MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      fetchUsers()
      setupViews()
      setupConstraints()
      navigationBar(isHidden: true)
      updateColors()
   }
}

//MARK: - Private Functions

private extension SearchViewController {
   func updateView() {
      tableView.reloadData()
   }
}

//MARK: - Networking

private extension SearchViewController {
   func fetchUsers() {
      UserService.fetchUsers { users in
         self.users = users
      }
   }
}

//MARK: - Appearance & Theming

private extension SearchViewController {
   func updateColors() {
      view.backgroundColor = ThemeManager.colors.backgroundPrimary
   }
}

//MARK: - Layout & Constraints

private extension SearchViewController {
   func setupViews() {
      view.addSubview(searchBar)
      view.addSubview(tableView)
   }
   
   func setupConstraints() {
      searchBar.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.trailing.equalToSuperview()
      }
      
      searchBar.searchTextField.snp.makeConstraints { make in
         make.top.bottom.equalToSuperview().inset(Constants.verticalPadding)
         make.leading.trailing.equalToSuperview().inset(Constants.horizontalPadding)
         make.height.equalTo(Constants.searchBarHeight)
      }
      
      tableView.snp.makeConstraints { make in
         make.top.equalTo(searchBar.snp.bottom)
         make.leading.trailing.bottom.equalToSuperview()
      }
   }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      print("DEBUG: Text did change \(searchText)")
   }
   
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      print(searchBar.isFirstResponder)
   }
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return users.isEmpty ? Constants.defaultNumberOfCells : users.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchCellIdentifier, for: indexPath)
      cell.startShimmering()
      
      guard let cell = cell as? SearchViewCell, !users.isEmpty else { return cell }
      cell.stopShimmering()
      let viewModel = SearchCellViewModel(user: users[indexPath.row])
      cell.setViewModel(viewModel)
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return SearchViewCell.baseContentHeight
   }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
   
}

//MARK: - Constants

private extension SearchViewController {
   enum Constants {
      static let searchCellIdentifier = "SearchViewCell"
      static let searchPlaceholder = "Search"
      static let defaultNumberOfCells: Int = 8
      
      //Sizes
      static let searchBarHeight: CGFloat = ThemeManager.sizes.defaultSearchBarHeight
      static let searchBarCornerRadius = Constants.searchBarHeight / 3
      
      //Spacings
      static let verticalPadding: CGFloat = ThemeManager.spacings.spacingM
      static let horizontalPadding: CGFloat = ThemeManager.spacings.spacingM
   }
}
