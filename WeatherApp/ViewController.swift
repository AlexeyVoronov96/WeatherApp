//
//  ViewController.swift
//  WeatherApp
//
//  Created by Алексей Воронов on 11/11/2018.
//  Copyright © 2018 Алексей Воронов. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //MARK: - Properies
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var apparentTemperatureLabel: UILabel!
    @IBOutlet var refreshButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    lazy var weatherManager = APIWeatherManager(apiKey: "a42cd8b5e4ac1cacdda13c6381721de7")
    var coordinates = Coordinates(latitude: 0, longitude: 0)
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    //MARK: - Refresh button
    @IBAction func refreshButtonAction(_ sender: Any) {
        getCurrentWeatherData()
    }
    
    //MARK: - Getting data
    func getCurrentWeatherData() {
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
                
                let alertController = UIAlertController(title: "Unable to get data".localize(), message: "\(error.localizedDescription)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                
                self.present(alertController, animated: true, completion: nil)
            default: break
            }
        }
    }

    //MARK: - Updating UI
    func updateUIWith(currentWeather: CurrentWeather) {
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.humidityLabel.text = currentWeather.humidityString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.apparentTemperatureLabel.text = currentWeather.apparentTemperatureString
    }

}

extension ViewController: CLLocationManagerDelegate {
    //MARK: - Getting current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last! as CLLocation
        self.coordinates.latitude = userLocation.coordinate.latitude
        self.coordinates.longitude = userLocation.coordinate.latitude
        self.getCurrentWeatherData()
    }
}
