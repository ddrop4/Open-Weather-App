//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by an.chernyshev on 24/01/2020.
//  Copyright © 2020 an.chernyshev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    var weather: [City] = []
    var city: City!
    let networkManager = NetworkManager()
    let tableView = UITableView(frame: .zero, style: .grouped)
    let customView = UILabel(frame: .zero)

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchCities()
        getCityNames()
    }
    
    // MARK: - UI Methods
    
    func addSubviews() {
        setupTableView()
        setupLeftLabel()
        setupRightButton()
    }
    
    func setupLeftLabel() {
        customView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        customView.text = "WEATHER"
        customView.textColor = UIColor.darkGray
        
        let leftBarButton = UIBarButtonItem(customView: customView)
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    func setupRightButton() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCity))
        self.navigationItem.setRightBarButton(rightBarButton, animated: true)
    }

    func setupTableView() {
        tableView.frame = CGRect(x: 0, y: 25, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 25)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.sectionHeaderHeight = 40
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }
    
    func fetchCities() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        
        do {
            weather = try managedContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getCityNames() {
        let array = weather
        for i in array {
            networkManager.weatherQuery(i.name!, completion: nil)
        }
    }
    
    @objc
    func addCity() {
        let alert = UIAlertController(title: "Добавьте свой город", message: "Название города должно быть написано используя только латинские буквы", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            guard let textField = alert.textFields?.first else { return }
            self.save(city: (textField.text)!)
            self.tableView.reloadData()
        }
        
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: nil)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func save(city: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "City", in: managedContext)
        let cityObject = NSManagedObject(entity: entity!, insertInto: managedContext) as! City
        
        cityObject.name = city
        do {
            try managedContext.save()
            weather.append(cityObject)
            print("Saved! Well done!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
