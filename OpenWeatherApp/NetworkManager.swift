//
//  NetworkManager.swift
//  OpenWeatherApp
//
//  Created by Anton Chernyshev on 26/01/2020.
//  Copyright © 2020 an.chernyshev. All rights reserved.
//

import Foundation

class NetworkManager {
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        let appId = "b6907d289e10d714a6e88b30761fae22"
        components.scheme = "https"
        components.host = "samples.openweathermap.org"
        components.path = "/data/2.5/forecast"
        components.queryItems = [URLQueryItem(name: "q", value: "London"),
                                 URLQueryItem(name: "appid", value: appId)]
        return components
    }
    
    func getData() {
        guard let url = self.urlComponents.url else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            print(url)
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
}
