//
//  Service.swift
//  WeatherAPP
//
//  Created by Tihomir Videnov on 6/29/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import Foundation


let MAIN_URL = "http://api.openweathermap.org/data/2.5/weather?q="
let UNITS = "&units=metric"
let APPID = "&APPID=0b9fe6eabf194e4247c44e2d8162726b"

typealias DownloadComplete = () -> ()
