//
//  MenuViewController.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 3/11/22.
//

import UIKit
import CoreLocation

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    let networkManager = WeatherNetworkManager()
    weak var delegate: MenuViewControllerDelegate?
    
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var stackView : UIStackView!
    var latitude : CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    enum MenuOptions: String, CaseIterable {
        case settings = "Settings"
        case share = "Share this app"
        case rate = "Rate this app"
    }
    
    private let currentLocationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current location"
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private let currentLocation: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    private let addCityButton: UIButton = {
        let button = UIButton()
        button.setTitle("  Add Location", for: .normal)
        button.backgroundColor = nil
        button.setTitleColor(UIColor(red: 251/255, green: 249/255, blue: 158/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        button.setImage(UIImage(named: "addLocation"), for: .normal)
        button.addTarget(self, action: #selector(handleAddPlaceButton), for: .touchUpInside)
        return button
    }()
    private let addCityButton1: UIButton = {
        let button = UIButton()
        button.setTitle("  Berlin, Germany", for: .normal)
        button.backgroundColor = nil
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        button.setImage(UIImage(named: "location"), for: .normal)
        button.addTarget(self, action: #selector(addPlaceBerlin), for: .touchUpInside)
        return button
    }()
    private let addCityButton2: UIButton = {
        let button = UIButton()
        button.setTitle("  Liverpool, UK", for: .normal)
        button.backgroundColor = nil
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        button.setImage(UIImage(named: "location"), for: .normal)
        button.addTarget(self, action: #selector(addPlaceLiverpool), for: .touchUpInside)
        return button
    }()
    private let addCityButton3: UIButton = {
        let button = UIButton()
        button.setTitle("  Washington, USA", for: .normal)
        button.backgroundColor = nil
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .bold)
        button.setImage(UIImage(named: "location"), for: .normal)
        button.addTarget(self, action: #selector(addPlaceWashington), for: .touchUpInside)
        return button
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isScrollEnabled = false
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan

        setupViews()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupViews() {
        view.addSubview(currentLocationLabel)
        view.addSubview(currentLocation)
        view.addSubview(addCityButton)
        view.addSubview(addCityButton1)
        view.addSubview(addCityButton2)
        view.addSubview(addCityButton3)
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        currentLocationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        currentLocationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        currentLocationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        currentLocation.topAnchor.constraint(equalTo: currentLocationLabel.bottomAnchor, constant: 20).isActive = true
        currentLocation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        currentLocation.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        addCityButton.translatesAutoresizingMaskIntoConstraints = false
        addCityButton.topAnchor.constraint(equalTo: currentLocation.bottomAnchor, constant: 130).isActive = true
        addCityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        addCityButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        addCityButton1.translatesAutoresizingMaskIntoConstraints = false
        addCityButton1.topAnchor.constraint(equalTo: addCityButton.bottomAnchor, constant: 30).isActive = true
        addCityButton1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        addCityButton1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        addCityButton2.translatesAutoresizingMaskIntoConstraints = false
        addCityButton2.topAnchor.constraint(equalTo: addCityButton1.bottomAnchor, constant: 30).isActive = true
        addCityButton2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        addCityButton2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        addCityButton3.translatesAutoresizingMaskIntoConstraints = false
        addCityButton3.topAnchor.constraint(equalTo: addCityButton2.bottomAnchor, constant: 30).isActive = true
        addCityButton3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        addCityButton3.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: addCityButton3.bottomAnchor, constant: 200).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        tableView.separatorStyle = .none
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        let location = locations[0].coordinate
        latitude = location.latitude
        longitude = location.longitude
        print("Long", longitude.description)
        print("Lat", latitude.description)
        loadDataUsingCoordinates(lat: latitude.description, lon: longitude.description)
    }
    
    func loadData(city: String) {
        networkManager.fetchCurrentWeather(city: city) { (weather) in
             print("Current Temperature", weather.main.temp.kelvinToCeliusConverter())
             let formatter = DateFormatter()
             formatter.dateFormat = "dd MMM yyyy" //yyyy
            _ = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
             
             DispatchQueue.main.async {
                 
                 self.currentLocation.text = "\(weather.name ?? "") , \(weather.sys.country ?? "")"
                 UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")
             }
         }
    }
    
    func loadDataUsingCoordinates(lat: String, lon: String) {
        networkManager.fetchCurrentLocationWeather(lat: lat, lon: lon) { (weather) in
             print("Current Temperature", weather.main.temp.kelvinToCeliusConverter())
             let formatter = DateFormatter()
             formatter.dateFormat = "dd MMM yyyy" //yyyy
            _ = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
             
             DispatchQueue.main.async {
                 self.currentLocation.text = "\(weather.name ?? "") , \(weather.sys.country ?? "")"
                UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")
             }
        }
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
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    
    @objc func handleAddPlaceButton() {
            let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
             alertController.addTextField { (textField : UITextField!) -> Void in
                 textField.placeholder = "City Name"
             }
             let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
                 let firstTextField = alertController.textFields![0] as UITextField
                 print("City Name: \(firstTextField.text ?? "")")
                guard let cityname = firstTextField.text else { return }
                self.loadData(city: cityname)
             })
             let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action : UIAlertAction!) -> Void in
                print("Cancel")
             })
          

             alertController.addAction(saveAction)
             alertController.addAction(cancelAction)

             self.present(alertController, animated: true, completion: nil)
        }
    
    @objc func addPlaceBerlin() {
        let cityName: String? = "Berlin"
        print("City Name: \(cityName!)")
        guard let cityname = cityName else { return }
                    loadData(city: cityname)
     }
    
    @objc func addPlaceLiverpool() {
        self.loadData(city: "Liverpool, UK")
     }
    
    @objc func addPlaceWashington() {
        self.loadData(city: "Washington, USA")
     }
}


