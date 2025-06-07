//
//  SearchViewController.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 20/12/24.
//

import UIKit

private enum SearchViewState {
   /// Fetching users from Firebase. Show shimmering effect.
   case loadingUsers
   
   /// Initial State shows all fetched users.
   case initial
   
   /// SearchBar is active and searches users. Show filtered users.
   case searchingUsers
}

final class SearchViewController: UIViewController {
   
   //MARK: - Properties
   
   private var state: SearchViewState = .loadingUsers
   private var users = [UserEntity]()
   private var filteredUsers = [UserEntity]()
      
   //MARK: - Subviews
   
   private lazy var searchBar: UISearchBar = {
      let searchBar = UISearchBar()
      searchBar.barTintColor = Constants.searchBarBackgroundColor
      searchBar.searchBarStyle = .default
      searchBar.keyboardType = .asciiCapable
      searchBar.returnKeyType = .search
      searchBar.tintColor = Constants.tintColor
      
      //Setup TextField
      searchBar.searchTextField.font = Constants.searchBarTextFont
      searchBar.searchTextField.textColor = Constants.textColor
      searchBar.searchTextField.borderStyle = .roundedRect
      searchBar.searchTextField.placeholder = Constants.searchPlaceholder
      
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
      updateView(for: .loadingUsers)
      setupViews()
      setupConstraints()
      setupNavigationBar()
      updateColors()
   }
}

//MARK: - Private Methods

private extension SearchViewController {
   func setupNavigationBar() {
      navigationBar(isHidden: true)
      navigationItem.backButtonTitle = Constants.backButtonTitle
      navigationController?.navigationBar.backgroundColor = Constants.navigationBarBackgroundColor
   }
   
   func updateView(for state: SearchViewState) {
      switch state {
      case .loadingUsers:
         self.state = .loadingUsers
         fetchUsers()
      case .initial:
         self.state = .initial
         tableView.reloadData()
      case .searchingUsers:
         self.state = .searchingUsers
         tableView.reloadData()
      }
   }
}

//MARK: - Networking

private extension SearchViewController {
   func fetchUsers() {
      UserService.shared.fetchUsers { users in
         self.users = users
         self.updateView(for: .initial)
      }
   }
}

//MARK: - Appearance & Theming

private extension SearchViewController {
   func updateColors() {
      view.backgroundColor = Constants.secondaryBackgroundColor
      tableView.backgroundColor = Constants.primaryBackgroundColor
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
         make.height.equalTo(Constants.searchBarHeight + Constants.verticalPadding * 2)
      }
      
      searchBar.searchTextField.snp.makeConstraints { make in
         make.leading.trailing.equalToSuperview().inset(Constants.horizontalPadding)
         make.centerY.equalToSuperview()
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
      guard !searchText.isEmpty else {
         updateView(for: .initial)
         return
      }
      
      let searchText = searchText.lowercased()
      filteredUsers = users.filter {
         $0.fullName.lowercased().contains(searchText) || $0.username.lowercased().contains(searchText)
      }
      
      updateView(for: .searchingUsers)
   }
   
   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      print("searchBarCancelButtonClicked")
   }
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      let numberOfRows: Int
      switch state {
      case .loadingUsers:
         numberOfRows = Constants.defaultNumberOfCells
      case .initial:
         numberOfRows = users.count
      case .searchingUsers:
         numberOfRows = filteredUsers.count
      }
      
      return numberOfRows
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchCellIdentifier, for: indexPath)
      guard let cell = cell as? SearchViewCell else { return cell }
      
      switch state {
      case .loadingUsers:
         cell.startShimmering()
         
      case .initial:
         cell.stopShimmering()
         let viewModel = SearchCellViewModel(user: users[indexPath.row])
         cell.setViewModel(viewModel)
         
      case .searchingUsers:
         let viewModel = SearchCellViewModel(user: filteredUsers[indexPath.row])
         cell.setViewModel(viewModel)
      }
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return SearchViewCell.baseContentHeight
   }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      defer { tableView.deselectRow(at: indexPath, animated: true) }
      let selectedUser: UserEntity
      
      switch state {
      case .initial:
         selectedUser = users[indexPath.row]
      case .searchingUsers:
         selectedUser = filteredUsers[indexPath.row]
      default: return
      }
      
      let controller = ProfileViewController(user: selectedUser)
      navigationController?.pushViewController(controller, animated: true)
   }
}

//MARK: - Constants

private extension SearchViewController {
   enum Constants {
      
      //Namings
      static let searchCellIdentifier = "SearchViewCell"
      static let searchPlaceholder = "Search"
      static let backButtonTitle = ""
      
      //Defaults
      static let defaultNumberOfCells: Int = 8
      
      //Sizes
      static let searchBarHeight: CGFloat = ThemeManager.sizes.defaultSearchBarHeight
      
      //Spacings
      static let verticalPadding: CGFloat = ThemeManager.spacings.spacingS
      static let horizontalPadding: CGFloat = ThemeManager.spacings.defaultHorizontalPadding
      
      //Fonts
      static let searchBarTextFont = ThemeManager.fonts.bodyLargeMedium
      
      //Colors
      static let textColor = ThemeManager.colors.textPrimaryDark
      static let tintColor = ThemeManager.colors.tintPrimaryDark
      static let primaryBackgroundColor = ThemeManager.colors.backgroundPrimary
      static let searchBarBackgroundColor = ThemeManager.colors.backgroundSecondary
      static let navigationBarBackgroundColor = ThemeManager.colors.backgroundSecondary
      static let secondaryBackgroundColor = ThemeManager.colors.backgroundSecondary
   }
}
