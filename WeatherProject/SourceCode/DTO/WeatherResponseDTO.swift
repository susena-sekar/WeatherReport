//
//  WeatherResponseDTO.swift
//  WeatherProject
//
//  Created by Susena on 06/04/22.
//

import Foundation

struct WeatherResponseDTO : Codable {
    var location : Location?
    var current  : CurrentDto?
    var forecast  : Forecast?
}

struct Location : Codable {
    var name      : String?
    var region    : String?
    var country   : String?
    var localtime : String?
}

struct CurrentDto : Codable {
    var last_updated  : String?
    var temp_c        : Double?
    var temp_f        : Double?
    var condition     : Condition?
}

struct Forecast : Codable {
    var forecastday : [Forecastday]?
}

struct Forecastday : Codable {
    var date       : String?
    var condition  : Condition?
    var day        : Day?
}

struct Condition : Codable {
    var text  : String?
    var icon  : String?
}

struct Day : Codable {
    var maxtemp_c   : Double?
    var mintemp_c   : Double?
    var avgtemp_c   : Double?
    var condition   : Condition?
}
