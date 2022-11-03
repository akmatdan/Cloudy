//
//  MenuViewController.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 3/11/22.
//

import UIKit
import CoreLocation

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    enum MenuOptions: String, CaseIterable {
        case settings = "Settings"
        case share = "Share"
        case rate = "Rate"
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.bottom, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    //MARK: - Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .systemCyan
        cell.contentView.backgroundColor = .systemCyan
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
    }
    
}
