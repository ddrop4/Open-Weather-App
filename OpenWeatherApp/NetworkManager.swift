//
//  NetworkManager.swift
//  OpenWeatherApp
//
//  Created by Anton Chernyshev on 26/01/2020.
//  Copyright © 2020 an.chernyshev. All rights reserved.
//

import Foundation
import UIKit

let vc = ViewController()
var array = vc.weatherArray

class NetworkManager {
    
    func weatherQuery(_ city: [City], _ indexPath: IndexPath, _ completion: (() -> ())?) {
        var components = URLComponents()
        let appId = "b6907d289e10d714a6e88b30761fae22"
        components.scheme = "https"
        components.host = "samples.openweathermap.org"
        components.path = "/data/2.5/weather"
        components.queryItems = [URLQueryItem(name: "q", value: city[indexPath.row].name),
                                 URLQueryItem(name: "appid", value: appId)]
        guard let url = components.url else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                    if let jsonKey = json["main"] as? [String: Any] {
                        if let temperature = jsonKey["temp"] as? Double {
                            let celcius = Int(temperature - 273.15)
                            array.append(celcius)
                            print(array)
//                            print(city[indexPath.row].name!)
                        } else {
                            // error
                        }
                    } else {
                        // error
                    }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
    
//    func pasteTemperature(_ city: [City], _ label: UILabel, _ indexPath: IndexPath) {

/*
 DispatchQueue.main.async {
     vc.setupLoader(animated: true)
     label.text = "Temperature in \(city[indexPath.row].name!) is \(celcius)"
 }
 */

    func configureURL(path: String, host: String?, scheme: String?, query: URLQueryItem) -> URL? {
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [URLQueryItem(name: "key", value: API_KEY), query]
        
        return components.url
    }
    
    func getData(cities: [String], completion: ((Weather) -> ())?) {
        for city in cities {
            guard let url = configureURL(path: "/v1/current.json", host: "api.weatherapi.com", scheme: "http", query: URLQueryItem(name: "q", value: city)) else { return }
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                    if let current = json["current"] as? [String: Any] {
                        if let key = current["temp_c"] as? Double, let date = current["last_updated"] as? String, let condition = current["condition"] as? [String: Any] {
                            if let text = condition["icon"] as? String {
                                let stats = Weather.init(currentWeather: Current(date: date, icon: text, temperature: Int(key)))
                                completion?(stats)
                            }
                        } else {
                            // error
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            dataTask.resume()
        }
    }
    
    func getPicture(urls: [String], completion: ((Data) -> ())?) {
        for iconURL in urls {
            let kek = iconURL.replacingOccurrences(of: "//", with: "http://")
            guard let url = URL(string: kek) else { return }
            let datatask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                completion?(data)
            }
            datatask.resume()
        }
    }    func configureURL(path: String, host: String?, scheme: String?, query: URLQueryItem) -> URL? {
            var components = URLComponents()
            
            components.scheme = scheme
            components.host = host
            components.path = path
            components.queryItems = [URLQueryItem(name: "key", value: API_KEY), query]
            
            return components.url
        }
        
        func getData(cities: [String], completion: ((Weather) -> ())?) {
            for city in cities {
                guard let url = configureURL(path: "/v1/current.json", host: "api.weatherapi.com", scheme: "http", query: URLQueryItem(name: "q", value: city)) else { return }
                let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data else { return }
                    do {
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                        if let current = json["current"] as? [String: Any] {
                            if let key = current["temp_c"] as? Double, let date = current["last_updated"] as? String, let condition = current["condition"] as? [String: Any] {
                                if let text = condition["icon"] as? String {
                                    let stats = Weather.init(currentWeather: Current(date: date, icon: text, temperature: Int(key)))
                                    completion?(stats)
                                }
                            } else {
                                // error
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                dataTask.resume()
            }
        }
        
        func getPicture(urls: [String], completion: ((Data) -> ())?) {
            for iconURL in urls {
                let kek = iconURL.replacingOccurrences(of: "//", with: "http://")
                guard let url = URL(string: kek) else { return }
                let datatask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data else { return }
                    completion?(data)
                }
                datatask.resume()
            }
        }

