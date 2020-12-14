//
//  WeatherModel.swift
//  Clima
//
//  Created by Mark Alford on 11/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    //setup data to be used in parsed data function, in WeatherManager
    let cityName: String
    let conditionId: Int
    let temp: Double
    
    //computed property syntax
//    var compProp: Int {
//        return 2 + 5
//    }
    
    //get rounded value of temperature from parsed Json
    var tempString: String { //
        let tempToString = String(format: "%.1f", temp)
        return tempToString
    }
    
    //computed property to decide what image to show, depending on weather
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
   
}
