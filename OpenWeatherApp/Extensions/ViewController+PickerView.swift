//
//  ViewController+PickerViewDelegate.swift
//  OpenWeatherApp
//
//  Created by an.chernyshev on 24/01/2020.
//  Copyright © 2020 an.chernyshev. All rights reserved.
//

import UIKit

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = cities[row]
        return row
    }
    
}
