//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by an.chernyshev on 24/01/2020.
//  Copyright © 2020 an.chernyshev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let networkManager = NetworkManager()
    
    //MARK: - Properties
    
    var cities: [String] = ["Miami", "Los-Angeles", "California", "New-York", "London", "Manchester", "Liverpool", "Birmingham", "Moscow", "Dortmund"]
    var temperature: [String] = []
    var date: [String] = []
    var temperatureSign: [String] = []

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        networkManager.getData()
    }
    
    // MARK: - UI Methods
    
    func addSubviews() {
        setupTableView()
        setupLeftLabel()
//        setupPicker()
        setupRightButton()
    }
    
    func setupLeftLabel() {
        let customView = UILabel(frame: .zero)
        
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
    
    @objc
    func addCity() {
        let addCityAlert = UIAlertController(title: "Добавьте свой город", message: "Название города должно быть написано используя только латинские буквы", preferredStyle: .alert)
        addCityAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        addCityAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        addCityAlert.addTextField(configurationHandler: nil)
        
        self.present(addCityAlert, animated: true, completion: nil)
    }
    
//    func setupPicker() {
//        let window = UIWindow()
//        let width = window.frame.size.width
//        let height = window.frame.size.height
//
//        let cityPicker = UIPickerView(frame: .zero)
//        cityPicker.frame = CGRect(x: 0, y: 300, width: width, height: height)
//
//        cityPicker.delegate = self
//        cityPicker.dataSource = self
//
//        view.addSubview(cityPicker)
//    }
    
    func setupTableView() {
//        let customView = UIView(frame: .zero)
//        let label = UILabel(frame: .zero)
//        label.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        label.text = "Cities"
//        label.textColor = .systemBlue
//        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        customView.addSubview(label)
        
        let window = UIWindow()
        let width = window.frame.size.width
        let height = window.frame.size.height
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.frame = CGRect(x: 0, y: 25, width: width, height: height)
//        tableView.tableHeaderView = customView
        tableView.sectionHeaderHeight = 40
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }

}
