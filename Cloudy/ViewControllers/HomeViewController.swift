//
//  HomeViewController.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 11/11/22.
//

import UIKit

class HomeViewController: UITabBarController, UICollectionViewDataSource, UICollectionViewDelegate {

    let networkManager = WeatherNetworkManager()
    var collectionView : UICollectionView!
    var forecastData: [ForecastTemperature] = []
    
    var loadData = MenuViewController()
    
    let currentLocation: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Home"
        
        currentPage()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(currentLocation)
        view.addSubview(collectionView)
        
        setupViews()
        
        let city = UserDefaults.standard.string(forKey: "SelectedCity") ?? ""
        print("City Forecast:", city)
        networkManager.fetchNextFiveWeatherForecast(city: city) { (forecast) in
            self.forecastData = forecast
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        forecastData = []
    }
    
    
    func currentPage() {
        print("Current Page: Home page")
    }
    
    
    func setupViews() {
        
        
        currentLocation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        currentLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        currentLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        currentLocation.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: currentLocation.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastData.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCell.reuseIdentifier, for: indexPath) as! ForecastCell
        cell.configure(with: forecastData[indexPath.row])
        return cell
     }
     

    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            self.createFeaturedSection()
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
    
    func createFeaturedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

       let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
       layoutItem.contentInsets = NSDirectionalEdgeInsets(top:5, leading: 5, bottom: 0, trailing: 5)

       let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
       let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

       let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
       layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
       return layoutSection
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
}
