//
//  ViewController+TableView.swift
//  OpenWeatherApp
//
//  Created by an.chernyshev on 24/01/2020.
//  Copyright © 2020 an.chernyshev. All rights reserved.
//

import UIKit
import CoreData

let network = NetworkManager()

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
        networkManager.weatherQuery(weather, indexPath, nil)
        if weather.count > 0 && weatherArray.count > 0 {
            cell.textLabel?.text = "Temperature in \(weather[indexPath.row].name!) is \(weatherArray)"
        } else {
            return cell
        }
//        if weather.count > 0 {
//            network.weatherQuery(weather, cell.textLabel!, indexPath, nil)
//        } else {
//            return cell
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if editingStyle == .delete {
            let city = weather[indexPath.row]
            managedContext.delete(city)
            weather.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        }
    }

}
