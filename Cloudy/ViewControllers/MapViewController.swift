//
//  MapViewController.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 10/11/22.
//

import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Map"
        
        currentPage()
    }
    
    func currentPage() {
        print("Current Page: Map page")
    }

}
