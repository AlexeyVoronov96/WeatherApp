//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Алексей Воронов on 11/11/2018.
//  Copyright © 2018 Алексей Воронов. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let apparentTemperature: Double
    let humidity: Double
    let pressure: Double
    let icon: UIImage
}

extension CurrentWeather: JSONDecodable {
    init?(JSON: [String: AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
        let apparentTemperature = JSON["apparentTemperature"] as? Double,
        let humidity = JSON["humidity"] as? Double,
        let pressure = JSON["pressure"] as? Double,
        let iconString = JSON["icon"] else {
            return nil
        }
        let icon = WeatherIconManager(rawValue: iconString as! String).image
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.humidity = humidity
        self.pressure = pressure
        self.icon = icon
    }
}

extension CurrentWeather {
    var pressureString: String {
        let miliMetres = " mm".localize()
        return "\(Int(pressure * 0.750062))" + miliMetres
    }
    var humidityString: String {
        return "\(Int(humidity * 100))%"
    }
    var temperatureString: String {
        return "\(Int(5 / 9 * (temperature - 32)))˚C"
    }
    var apparentTemperatureString: String {
        let feels = "Feels Like:".localize()
        return feels + " \(Int(5 / 9 * (apparentTemperature - 32)))˚C"
    }
}

