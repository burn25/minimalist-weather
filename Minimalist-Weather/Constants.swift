//
//  Constants.swift
//  Minimalist-Weather
//
//  Created by Jeremy Burnham on 6/1/16.
//  Copyright © 2016 Jeremy Burnham. All rights reserved.
//

import Foundation

let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?"
let API_KEY = "&APPID=468a6cd3c3574ee61e495759162df680"

let URL_BASE_FORCAST = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let FORCAST_COUNT = "&cnt=5"

typealias DownloadComplete = () -> ()
