//
//  WeatherManager.swift
//  Clima
//
//  Created by Mark Alford on 11/6/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

//MARK: - Custom Delegate

//methods that will be used in ViewController
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    //APIs are standard commands (functions, objects, protocols, etc. used for getting third party data from internet)
    let apiKey = Constants.apiKey
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?&units=imperial"
    //the urlParameters help get data for weather
    
    //allows user text input to find city name weather
    func fetchWeather (cityName: String){
        let weatherString = "\(weatherURL)\(apiKey)&q=\(cityName)"// will add cityName to the weatherURL
        performRequest(with: weatherString)
    }
    
    //allows user to find gps location weather
    func fetchWeather (latitude:  CLLocationDegrees, longitude: CLLocationDegrees){
        let weatherString = "\(weatherURL)\(apiKey)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: weatherString)
    }
    
    //delegate for WeatherViewController to use
    var delegate: WeatherManagerDelegate?
    
    //MARK: - Networking
    //STEPS TO PERFORM THE NETWORKING FUNCTION
    func performRequest (with urlString: String){
        //1 create url
        if let url = URL(string: urlString) {
            //2 create the urlSession
            let session = URLSession(configuration: .default)
            //3 give the urlSession a task
            let task = session.dataTask(with: url) { (data, urlResponse, error) in //trailing closure
                //if there is an error in getting back the data, print the error
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                //if the data from the webserver is good, print and store data
                if let safeData = data {
                    //5 refer to the parsing function
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4 perform the task
            task.resume()
        }
        
    }
    
    //MARK: - Parsing Json Data
    //this function is used for formatting the webserver data down to a readable chunk
    //STEPS TO PARSE JSON WEBSERVER DATA TO READABLE CHUNKS
    func parseJSON (_ weatherData: Data) -> WeatherModel? { //5
        //1 access the Json decoding class
        let decoder = JSONDecoder()
        //2 setup parse with do and catch
        do {
            //3.1 this gets access to WeatherData struct, where we intialize ALL properties. these properties are where the web server data properties will go into.
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData) //3 MAKE WeatherData struct in WeatherData.swift file
            
            //4 get back parsed data from JSON
            //with regards to MVC, to use the methods from another model {{
            let id = decodedData.weather[0].id //set a var equal to your parsed data
            let name = decodedData.name //set a var equal to your parsed data
            let temperature = decodedData.main.temp //set a var equal to your parsed data
            let weatherM = WeatherModel(cityName: name, conditionId: id, temp: temperature) //when calling the model in, use those vars as its parameters
            //}}
            
            //print out parsed data from the WeatherData Struct, refer the that {{
            print(id) //prints out a WeatherData struct property, name: String
            print(name)  //prints out a WeatherData struct property, main.temp
            print(decodedData.weather[0].description)
            print(weatherM.tempString)
            print(weatherM.conditionName)//accessing a weather model COMPUTED PROPERTY, which is a var, that acts like a returning method
            // }}
            
            return weatherM //5 return the model, in order to use it in View Controller
            
        } catch{
            print(error)
            return nil //6 needed to be return, because WeatherMoel?
        }
    }
    
    
}

