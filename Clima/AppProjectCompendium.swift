//
//  AppProjectCompendium.swift
//  Clima
//
//  Created by Mark Alford on 11/13/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

//MARK: - Features
//1 enter a city location, to get its weather and temperature

//MARK: - Patterns
//MVC pattern.
//all logic and data go into a model folder, through methods and properties
//the ViewController ONLY calls these methods

//DELEGATE pattern
//1 the class (delegator) has methods/things it does. but this delegator ALSO has methods
//2 the methods it TELLS the other classes/structs (delegates) to do are syntaxed like this
    //2.1 delegate?.performProtocolFunc()
//2.1 delegate?.performProtocolFunc() IS THE METHOD that the delegate is told to do by the delegator
//3 this method will also HAVE TO BE IN A PROTOCOL, this protocol is within the same delegator file
//4 within the delegator, make this key. ALL delegates will do the delegator's methods with it
    //4.1 var delegate: ProtocolName?
//4.1 this is the key for the delegate struct/class
//5 within the delegate, in order for it to PERFORM THOSE METHODS OF THE DELEGATOR, have it
    //5.1 take up the protocol, along with func stubs
    //5.2 make var delegator = DelegatorClassName() in top of struct
    //5.3 make delegator.delegate = self within viewDidLoad func
//6 BOOM, now it can delegate!

//MARK: - Goals
//OVERALL GOALS
//1 type in city to get its weather
//2 weather includes temperature, in Celsius (programmed in Fahrenheit)
//3 can get current coordinates, and shows city name and temperature
//4 shows image relating to current weather
//5 background has light mode and dark mode.

//MODEL, VIEW, CONTROLLER
//MODEL- handle weather and location logic/data
//VIEW- handle app screen
//CONTROLLER- handle buttons and texfield, which will operate the Model methods

