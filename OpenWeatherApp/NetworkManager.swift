//
//  NetworkManager.swift
//  OpenWeatherApp
//
//  Created by Anton Chernyshev on 26/01/2020.
//  Copyright © 2020 an.chernyshev. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var temp: Double
}

class NetworkManager {
    
    func weatherQuery(_ city: String, completion: ((Data) -> ())?) {
        var components = URLComponents()
        let appId = "b6907d289e10d714a6e88b30761fae22"
        components.scheme = "https"
        components.host = "samples.openweathermap.org"
        components.path = "/data/2.5/forecast"
        components.queryItems = [URLQueryItem(name: "q", value: city),
                                 URLQueryItem(name: "appid", value: appId)]
        guard let url = components.url else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                if let jsonDict = json["list"] as? [[String: Any]] {
//                    print(jsonDict)
                    for jsonKey in jsonDict {
                        if let jsonValue = jsonKey["main"] as? [String: Any] {
//                            print(jsonValue)
                            if let jsonValuev = jsonValue["temp"] as? Double {
                                print("That is current temperature in \(city) - \(jsonValuev)")
                            } else {
                                // error
                            }
                        } else {
                        // error
                        }
                    }
                } else {
                    // error
                }
                print("\(city) is printed")
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func downloadTemperature(_ city: String) {
        weatherQuery(city) { (json) in
            
        }
    }
    
}
