//
//  ForecastAdapter.swift
//  WeatherApp
//
//  Created by Alan Rodriguez on 6/4/19.
//  Copyright © 2019 Targaryen. All rights reserved.
//

import Foundation
import OAuthSwift

enum APIResponseType: String {
    case json = "json"
    case xml = "xml"
}

enum UnitType: String {
    case imperial = "f"
    case metric = "c"
}

private struct Credentials {
    var appId = ""
    var clientId = ""
    var clientSecret = ""
}

class ForecastAdapter {
    private let credentials = Credentials(appId: "2tZPA834", clientId: "dj0yJmk9TWZmRjlhVnU0NWt2JnM9Y29uc3VtZXJzZWNyZXQmc3Y9MCZ4PWIz", clientSecret: "3c8bb1e9916a130478f2a4bd474cf1d6814cd9ca")
    private let url = "https://weather-ydn-yql.media.yahoo.com/forecastrss"
    private let oauth: OAuth1Swift

    static let shared = ForecastAdapter()

    private init() {
        oauth = OAuth1Swift(consumerKey: credentials.clientId, consumerSecret: credentials.clientSecret)
    }

    private var headers: [String: String] {
        return [
            "X-Yahoo-App-Id": credentials.appId]
    }

    private func makeRequest(parameters:[String: String], failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void) {
        oauth.client.request(url, method: .GET, parameters: parameters, headers: headers, body: nil, checkTokenExpiration: true, success: success, failure: failure)
    }

    func weather(location: String, failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void, format: APIResponseType, unit: UnitType) {
        makeRequest(parameters: ["location": location, "format": format.rawValue, "u": unit.rawValue], failure: failure, success: success)
    }
}
