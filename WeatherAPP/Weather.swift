//
//  Weather.swift
//  WeatherAPP
//
//  Created by Tihomir Videnov on 6/28/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    private var _temperature: Int!
    private var _maxTemp: Int!
    private var _minTemp: Int!
    private var _city: String!
    private var _currentCity: String!
    private var _country: String!
    private var _humidity: Int!
    private var _wind: String!
    private var _weatherURL: String!
    private var _weather: String!
    private var _description: String!
    private var _icon: String!
    private var _day: String!
    private var _date: String!
    private var _time: String!
    private var _bg: String!
    private var _resultQuery: Bool!
    
    
    init(city: String) {
        self._city = city
        
        _weatherURL = "\(MAIN_URL)\(self._city)\(UNITS)\(APPID)"
        print(_weatherURL)
    }
    
    var resultQuery: Bool {
        if _resultQuery == nil {
            return false
        }
        return _resultQuery
    }
    
    var bg: String {
        if _bg == nil {
            return "bg1"
        }
        return _bg
    }
    
    var temperature: Int {
        if _temperature == nil {
            return 0
        }
        return _temperature
    }
    
    var maxTemp: Int {
        if _maxTemp == nil {
            return 0
        }
        return _maxTemp
    }
    
    var minTemp: Int {
        if _minTemp == nil {
            return 0
        }
        return _minTemp
    }
    
    var city: String {
            if _city == nil {
                return ""
            }
        return _city
    }
    
    var country: String {
        if _country == nil {
            return ""
        }
        return _country
    }
    
    var humidity: Int {
        if _humidity == nil {
            return 0
        }
        return _humidity
    }
    
    var wind: String {
        if _wind == nil {
            return ""
        }
        return _wind
    }
    
    var weather: String {
        if _weather == nil {
            return ""
        }
        return _weather
    }
    
    var description:String {
        if _description == nil {
            return ""
        }
        return _description
    }
    
    var icon: String {
        if _icon == nil {
            return ""
        }
        return _icon
    }
    
    var currentCity: String {
        if _currentCity == nil {
            return ""
        }
        return _currentCity
    }
    
    var day: String {
        get {
            if _day == nil {
                return ""
            }
            return _day
        }
    }
    
    var date: String {
        get {
            if _date == nil {
                return ""
            }
            return _date
        }
    }
    
    var time: String {
        get {
            if _time == nil {
                return ""
            }
            return _time
        }
    }

    
    
    func downloadWeather(completed: DownloadComplete){
        let url = NSURL(string: self._weatherURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            //print(response.request)  // original URL request
            //print(response.response) // URL response
            //print(response.data)     // server data
            //print(response.result.value)
            if result.value == nil {
                self._resultQuery = false
            } else {
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let dt = dict["dt"] as? Double {
                    let date = NSDate(timeIntervalSince1970: dt)
                    let dayFormatter = NSDateFormatter()
                    let dateFormatter = NSDateFormatter()
                    let timeFormatter = NSDateFormatter()
                    dayFormatter.dateFormat = "EEEE"
                    dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
                    timeFormatter.dateFormat = "h:mm a"
                    self._day = dayFormatter.stringFromDate(date)
                    self._date = dateFormatter.stringFromDate(date)
                    self._time = timeFormatter.stringFromDate(date)
                }
                
                if let tempDetails = dict["main"] as? Dictionary<String, AnyObject> {
                    if let humidity = tempDetails["humidity"] as? Int {
                        self._humidity = humidity
                        
                    }
                    if let temp = tempDetails["temp"] as? Int {
                        self._temperature = temp
                        switch(temp) {
                        case -20...5:
                            self._bg = "bg_cold"
                        case 6...25:
                            self._bg = "bg1"
                        case 26...50:
                            self._bg = "bg_warm"
                        default:
                            self._bg = "bg1"
                        }
                        
                    }
                    if let maxTemp = tempDetails["temp_max"] as? Int {
                        self._maxTemp = maxTemp
                        
                    }
                    if let minTemp = tempDetails["temp_min"] as? Int {
                        self._minTemp = minTemp
                        
                    }
                }
                
                if let currentCity = dict["name"] as? String {
                    self._currentCity = currentCity
                    
                }
                
                if let currentCountry = dict["sys"] as? Dictionary<String, AnyObject> {
                    if let country = currentCountry["country"] as? String {
                        self._country = country
                        
                    }
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] where weather.count > 0 {
                    if let type = weather[0]["main"] as? String {
                        self._weather = type
                        
                    }
                    
                    if let description = weather[0]["description"] as? String {
                        self._description = description.capitalizedString
                        
                    }
                    
                    if let icon = weather[0]["icon"] as? String {
                        self._icon = icon
                        
                    }
                }
                
                if let wind = dict["wind"] as? Dictionary<String ,AnyObject> {
                    if let speed = wind["speed"] as? Double {
                        self._wind = "\(speed)m/s"
                        
                    }
                }
                
//                print(self._wind)
//                print(self._description)
//                print(self._weather)
//                print(self._icon)
//                print(self._currentCity)
//                print(self._country)
//                print(self._temperature)
//                print(self._minTemp)
//                print(self._maxTemp)
//                print(self._humidity)


               self._resultQuery = true
            }
            completed()
        }
        }
    }
    
}