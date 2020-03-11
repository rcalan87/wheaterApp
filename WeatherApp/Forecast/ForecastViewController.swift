//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Alan Rodriguez on 6/4/19.
//  Copyright © 2019 Targaryen. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var forecastLabel: UILabel!
    @IBOutlet var cityTextField: UITextField!
    
    var viewModel = ForecastViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.addTarget(self, action: #selector(getTempButton(_:)), for: UIControl.Event.editingDidEndOnExit)
    }

    @IBAction func getTempButton(_ sender: UIButton) {
        cityTextField.resignFirstResponder()
        guard let city = cityTextField.text else { return }
        viewModel.getForecast(from: city)
        updateLabels()
    }

    private func updateLabels() {
        viewModel.forecast = { [weak self] forecast in
            self?.forecastLabel.text = forecast
        }

        viewModel.temperature = { [weak self] temperature in
            self?.tempLabel.text = temperature
        }
    }
}

