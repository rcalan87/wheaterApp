//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Alan Rodriguez on 6/4/19.
//  Copyright © 2019 Targaryen. All rights reserved.
//

import Foundation

class ForecastViewModel {
    var temperature: ((String) -> Void)?
    var forecast: ((String) -> Void)?

    func getForecast(from city: String?) {
        guard let location = city else { return }
        ForecastAdapter.shared.weather(location: location, failure: { error in
            print(error.localizedDescription)
        }, success: { response in
            do {
                try print(response.jsonObject())
                let json = try response.jsonObject()
                guard let results = json as? [String: Any] else { return }
                guard let observation = results["current_observation"] as? [String: Any] else { return }
                guard let condition = observation["condition"] as? [String: Any] else { return }
                guard let temperature = condition["temperature"] as? Int else { return }
                guard let forecast = condition["text"] as? String else { return }

                self.temperature?(String(temperature) + "º")
                self.forecast?(forecast)
            } catch {
                print(error.localizedDescription)
            }
        }, format: .json, unit: .metric)
    }
}
