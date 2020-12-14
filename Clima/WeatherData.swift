//
//  WeatherData.swift
//  Clima
//
//  Created by Mark Alford on 11/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

//IN ORDER TO PARSE DATA, PARSE IT DEPENDING ON DATA TYPES WITHIN JSON TREE

//Codable is a type alias, that has decoadable and encodable in it, the latter begin able to turn data BACK into JSON
struct WeatherData: Codable { //the top data source
    let name: String //for just 1st level members of the tree, initialize its var name and type
    //for objects within the tree, perform TASK A.
    let main: Main //A.2 refer to the struct with a var name and that struct name (type)
    //for arrays within the tree, perform TASK B.
    let weather: [Weather] //B.2 refer to the struct with a var name and that struct [name] (type)
}

//TASK A- decoding objects
//A.1 make a struct for the Object within the JSON tree
struct Main: Codable {
    //A.3 initialize those object members with their name and type {{
    let temp: Double
    let feels_like: Double
    //}}
} //when refering to the members in WeatherManager, use main.temp or main.feels_like as example

//TASK B- decoding arrays
//B.1 make a struct for the Array within the JSON tree
struct Weather: Codable {
    //B.3 initialize those array members with their name and type {{
    let description: String
    let id: Int
    //}}
} //when refering to the members in WeatherManager, use weather[0].description as example

