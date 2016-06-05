//
//  Weather.swift
//  Minimalist-Weather
//
//  Created by Jeremy Burnham on 6/1/16.
//  Copyright © 2016 Jeremy Burnham. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    private var _lat: String!
    private var _lon: String!
    private var _weatherUrl: String!
    private var _name: String!
    private var _description: String!
    private var _icon: String!
    private var _temp: String!
    private var _convertedTemp: Int!
    private var _minTemp: String!
    private var _maxTemp: String!
    private var _windSpeed: String!
    private var _windDirection: String!
    private var _humidity: String!

    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var temp: String {
        if _temp == nil {
            _temp = ""
        }
        return _temp
    }
    
    var icon: String {
        if _icon == nil {
            _icon = ""
        }
        return _icon
    }
    
    var minTemp: String {
        if _minTemp == nil {
            _minTemp = ""
        }
        return _minTemp
    }
    
    var maxTemp: String {
        if _maxTemp == nil {
            _maxTemp = ""
        }
        return _maxTemp
    }
    
    var windSpeed: String {
        if _windSpeed == nil {
            _windSpeed = ""
        }
        if _windDirection == nil {
            _windDirection = ""
        }
        return "\(_windSpeed) \(_windDirection)"
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    
        
    init(lat: String, lon: String) {
        self._lat = lat
        self._lon = lon
        
        var units: String!
        
        if isFahrenheit {
            units = "&units=imperial"
        } else {
            units = "&units=metric"
        }
        
        _weatherUrl = "\(URL_BASE)lat=\(lat)&lon=\(lon)\(units)\(API_KEY)"
        
    }
    
   func downloadWeather(completed: DownloadComplete) {
        
        let url = NSURL(string: _weatherUrl)!

    
        Alamofire.request(.GET, url).responseJSON { response in let result = response.result
            if let dict = result.value as? [String:AnyObject] {
                
                print(dict)
                if let name = dict["name"] as? String {
                    self._name = name
                }
                print(self._name)
                
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] where weather.count > 0 {
                    if let desc = weather[0]["description"] as? String {
                        self._description = desc
                    }
                    if let icon = weather[0]["icon"] as? String {
                        self._icon = icon
                    }
                    
                    print(self._description)
                    print(self._icon)
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> where main.count > 0 {
                    if let temp = main["temp"] as? Int {
                        self._temp = "\(temp)"
                    }
                    print(self._temp)
                    if let minTemp = main["temp_min"] as? Int {
                        self._minTemp = "\(minTemp)"
                    }
                    print(self._minTemp)
                    if let maxTemp = main["temp_max"] as? Int {
                        self._maxTemp = "\(maxTemp)"
                    }
                    if let humidity = main["humidity"] as? Int {
                        self._humidity = "\(humidity)"
                    }
                }
                
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> where wind.count > 0 {
                    if let speed = wind["speed"] as? Double {
                        self._windSpeed = "\(speed)"
                    }
                    if let direct = wind["deg"] as? Double {
                        self._windDirection = self.windDirection(direct)
                    }
                    print(self._windSpeed)
                    print(self._windDirection)
                }
                
            }
            
            completed()
        }
    }
        
    func windDirection(deg: Double) -> String {
        var direction: String!
        
        if deg == 0 {
            direction = "N"
        } else if deg > 0 && deg <= 90 {
            direction = "NE"
        } else if deg > 90 && deg <= 180 {
            direction = "SE"
        } else if deg == 180 {
            direction = "S"
        } else if deg > 180 && deg <= 270 {
            direction = "SW"
        } else if deg == 270 {
            direction = "W"
        } else if deg > 270 && deg <= 360 {
            direction = "NW"
        } else {
            direction = ""
        }
        
        return direction
    }
}