//
//  AnimateMenuButton.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 3/11/22.
//

import UIKit

extension ViewController: HomeViewControllerDelegate {
    
    func didTapMenuButton() {
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
                }
            }
        }
        
    }
}
