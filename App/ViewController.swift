//
//  ViewController.swift
//  NavigationControllerHW
//
//  Created by Anastasiya Orlova on 07.06.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let usersList = UsersList()
        
    private lazy var usersListTableView: UITableView = {
        let usersListTableView = UITableView(frame: .zero, style: .insetGrouped)
        usersListTableView.dataSource = self
        usersListTableView.delegate = self
        usersListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "RoutingCellId")
        usersListTableView.translatesAutoresizingMaskIntoConstraints = false
        usersListTableView.backgroundColor = .systemGray6
        return usersListTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Список пользователей"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24.0, weight: .heavy)]
        navigationController?.navigationBar.prefersLargeTitles = true
        usersListTableView.reloadData()
        view.addSubview(usersListTableView)
        
        NSLayoutConstraint.activate([
            usersListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            usersListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usersListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usersListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
    

extension ViewController: UITableViewDataSource {

    func tableView(_ usersListView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usersList.users.count
    }

    func tableView(_ usersListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = usersListView.dequeueReusableCell(withIdentifier: "RoutingCellId", for: indexPath)
        cell.accessoryType = .disclosureIndicator

        let user = usersList.users[indexPath.row]
        cell.textLabel?.text = user.fullName
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ usersListView: UITableView, didSelectRowAt indexPath: IndexPath) {
        usersListView.deselectRow(at: indexPath, animated: true)

        let userDetailsVC = UserDetailsViewController()
        let user = usersList.users[indexPath.row]
        userDetailsVC.userInfo = user
        
        guard let usersListVC = self.navigationController else { return }
        
        usersListVC.pushViewController(userDetailsVC, animated: true)
    }
}


