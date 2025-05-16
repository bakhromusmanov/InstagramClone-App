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
   
   private lazy var searchController: UISearchController = {
      let searchController = UISearchController(searchResultsController: nil)
      searchController.searchResultsUpdater = self
      searchController.searchBar.placeholder = Constants.searchPlaceholder
      searchController.searchBar.showsCancelButton = false
      return searchController
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
      navigationBar(isHidden: false)
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
      view.addSubview(tableView)
      //view.addSubview(searchController)
   }
   
   func setupConstraints() {
      tableView.snp.makeConstraints { make in
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
         make.leading.trailing.bottom.equalToSuperview()
      }
   }
}

//MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
   func updateSearchResults(for searchController: UISearchController) {
      
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
      static let defaultNumberOfCells: Int = 12
   }
}
