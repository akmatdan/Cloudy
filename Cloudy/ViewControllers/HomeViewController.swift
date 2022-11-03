//
//  HomeViewController.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 3/11/22.
//

import UIKit

protocol HomeViewControllerDelegate : AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        title = "Weather"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "bar")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(didTapMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(didTapSearchButton))
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    
    @objc func didTapSearchButton() {
        
    }
}
