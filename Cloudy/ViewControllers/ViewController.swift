//
//  ViewController.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 29/10/22.
//

import UIKit


class ViewController: UIViewController {
    
    var navVC: UINavigationController?
    
    let menuVC = MenuViewController()
    
    let homeVC = MainViewController()
    let forecastVC = ForecastViewController()
    let mapVC = MapViewController()
    
    enum MenuState {
        case opened
        case closed
    }
    
    var menuState: MenuState = .closed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        addChildVCs()
    }
    
    private func addChildVCs() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
                
        // Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}

    //MARK: - Extensions

extension ViewController: MainViewControllerDelegate {
    
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            // open state
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x  = self.homeVC.view.frame.width - 130
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
            
        case .opened:
            // close state
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x  = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
        switch menuItem {
        case .rate:
            let vc = RateViewController()
            self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        case .settings:
            let vc = SettingsViewController()
            self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        case .share:
            let vc = ShareViewController()
            self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }
    }
}
