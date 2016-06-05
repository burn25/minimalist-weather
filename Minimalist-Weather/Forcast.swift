//
//  Forcast.swift
//  Minimalist-Weather
//
//  Created by Jeremy Burnham on 6/4/16.
//  Copyright © 2016 Jeremy Burnham. All rights reserved.
//

import Foundation
import Alamofire


class Forcast {
    
    private var _lat: String!
    private var _lon: String!
    private var _forcastUrl: String!
    private var _tempForcast = [String]()
    private var _iconForcast = [String]()
    
    var tempForcast: [String] {
        return _tempForcast
    }
    
    var iconForcast: [String] {
        return _iconForcast
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
        
        _forcastUrl = "\(URL_BASE_FORCAST)lat=\(lat)&lon=\(lon)\(units)\(FORCAST_COUNT)\(API_KEY)"
        
    }

    func downloadForcast(completed: DownloadComplete) {
    
        let forcastUrl = NSURL(string: _forcastUrl)!
    
    
        Alamofire.request(.GET, forcastUrl).responseJSON { response in let result = response.result
            if let dict = result.value as? [String:AnyObject] {
                if let weather = dict["list"] as? [Dictionary<String,AnyObject>] where weather.count > 0 {
                
                    for var i = 0; i < dict.count; i += 1 {
                    
                        var minimumTemp: String!
                        var maximumTemp: String!
                        var temps: String!
                    
                        if let temp = weather[i]["temp"] as? Dictionary<String,AnyObject> where temp.count > 0 {
                            if let minTemp = temp["min"] as? Int {
                                minimumTemp = "\(minTemp)"
                            }
                            if let maxTemp = temp["max"] as? Int {
                                maximumTemp = "\(maxTemp)"
                            }
                            temps = "\(minimumTemp) | \(maximumTemp)"
                            temperaturs.append(temps)
                            print(temperaturs.count)
                        }

                        if let weat = weather[i]["weather"] as? [Dictionary<String,AnyObject>] where weat.count > 0 {
                            if let icon = weat[0]["icon"] as? String {
                                icons.append(icon)
                            }
                        }
                    
                    }
                    
                    
                }
            }
          
            completed()
        }
        
    }

}