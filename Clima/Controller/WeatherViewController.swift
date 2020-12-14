//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation //S1 must import for working with GPS

class WeatherViewController: UIViewController {
    
    //setup UI elements
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    
    //get access to WeatherManager
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()// S2 set locationManager, in charge of getting current location of phone

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        locationManager.delegate = self //S3 set the location
        
        locationManager.requestWhenInUseAuthorization()// S4 request user permission for gps, then go to Info.plist and add Privacy- Location When in Use usage description
        locationManager.requestLocation()// S5 request location
        
        //UITextField delegates allow us to use/connect to ios keyboard "enter" button
        searchField.delegate = self //textfield should report back to this ViewController
        weatherManager.delegate = self //weatherManager delegate
       
    }
    
    

    //button functionality for GPS finding
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - UItextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    //ends the editing of the textfield, which performs same functionality of  func textFieldDidEndEditing
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchField.endEditing(true)
        print(searchField.text!)
    
    }
    
    //when enter button is pressed on keypad, execute code
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        print(searchField.text!)
        return true
    }
    
    //if textfield has no input in it, when enter button is pressed, textfield will tell user to type first.
    //this blocks the 'no input to begin with' error when user doesnt even type anything in textfield.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "type something"
            return false
        }
    }
    
    //when the textfield stop editing officially, done by enter button on keypad
    func textFieldDidEndEditing(_ textField: UITextField) {
        //use the searchField.text to get the weather
        //if let is good for checking optionals
        if let city = searchField.text { //THIS STARTS IT ALL IN THE WEATHER MANAGER
            weatherManager.fetchWeather(cityName: city)
        }
    }
}

//MARK: - WeatherManagerDelegate
//when making code snippets, use <> and ## between those angle brackets
extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather.temp)
        //with regard to Delegate Patterns and completion handlers, use DispatchQueue to change UI
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            //UIImage(systemName: ) uses string resources of images to set the image
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - LocationManagerDelegate

//S6 set the extension to the CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    
    
    
    //S7 set these 2 functions {{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got location")
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            //function in WeatherManger that uses coordinates in query instead of cityName
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    //}}
    
    
}

