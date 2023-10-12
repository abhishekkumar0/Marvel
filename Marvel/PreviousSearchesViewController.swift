//
//  SearchResultViewController.swift
//  Marvel
//
//  Created by Abhishek on 11/10/23.
//

import UIKit
import CoreData

class PreviousSearchesViewController: UITableViewController {

    var originalUserSearches = [UserSearches]() // Store the original data
    var userSearches = [UserSearches]()
    var userTappedOnSearchedResults: ((_ search: String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    private func configureView() {
        self.originalUserSearches = DatabaseOperations.shared.loadItems() ?? []
        self.userSearches = originalUserSearches
        self.setUpTableView()
    }

    public func updateUserResults(text: String) {
        if text.isEmpty {
            resetFilter()
        } else {
            filterUserSearches(with: text)
        }
        self.tableView.reloadData()
    }

    private func filterUserSearches(with searchText: String) {
        self.userSearches.removeAll()
        self.userSearches = originalUserSearches.filter { $0.search!.contains(searchText) }
    }

    private func resetFilter() {
        self.userSearches = originalUserSearches
    }
    
    public func updateData(userSearches: UserSearches){
        self.originalUserSearches.append(userSearches)
        self.userSearches = originalUserSearches
        self.tableView.reloadData()
    }

    private func setUpTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userSearches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.userSearches[indexPath.row].search
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard userSearches.count > indexPath.row, let search = userSearches[indexPath.row].search else { return }
        self.userTappedOnSearchedResults?(search)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
