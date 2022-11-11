//
//  HomeViewController.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 3/11/22.
//

import UIKit

protocol MainViewControllerDelegate : AnyObject {
    func didTapMenuButton()
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    
    var stackView = UIStackView()
    
    let tabBar = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "bar")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(didTapMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(didTapSearchButton))
        
        transparentNavigationBar()
        
        tabBarFunc()
    }
    
    func tabBarFunc() {
        let homeVC = HomeViewController()
        let forecastVC = ForecastViewController()
        let mapVC = MapViewController()
        
        let item1 = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.fill"), tag: 0)
        let item2 = UITabBarItem(title: "Forecast", image: UIImage(systemName: "chart.bar.doc.horizontal"), tag: 1)
        let item3 = UITabBarItem(title: "Map", image: UIImage(systemName: "map.fill"), tag: 2)
    
        homeVC.tabBarItem = item1
        forecastVC.tabBarItem = item2
        mapVC.tabBarItem = item3
        
        tabBar.viewControllers = [homeVC,forecastVC,mapVC]
        
        self.view.addSubview(tabBar.view)
    }
    
    func transparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "", style: .plain, target: nil, action: nil)
    }

    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    
    @objc func didTapSearchButton() {
        
    }
    
}

