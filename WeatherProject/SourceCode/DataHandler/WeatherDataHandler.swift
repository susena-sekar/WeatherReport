//
//  WeatherDataHandler.swift
//  WeatherProject
//
//  Created by Susena on 06/04/22.
//

import Foundation

//  this struct decides the report from Api or local

enum MYError: Error{
    case failedToGetReport
    case networkIssue
}

struct WeatherDataHandler {
    
    private let APIKEY = "522db6a157a748e2996212343221502"
    private var WEATHER_URL = "https://api.weatherapi.com/v1/forecast.json?key={API_KEY}&q={NAME_OF_CITY}&days=7&aqi=no&alerts=no"
    
    
    mutating func getWeatherReports(city: String, Complition handler : @escaping (Result<WeatherResponseDTO, Error>) -> Void){
        
        WEATHER_URL = WEATHER_URL.replacingOccurrences(of: "{API_KEY}", with: APIKEY)
        WEATHER_URL = WEATHER_URL.replacingOccurrences(of: "{NAME_OF_CITY}", with: city)
        
        guard let url = URL(string: WEATHER_URL) else {
            handler(.failure(MYError.failedToGetReport))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                handler(.failure(error ?? MYError.failedToGetReport))
                return
            }
            
            do {
                let jsonDic = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                debugPrint(jsonDic)
                UserDefaults.standard.weatherReports = jsonDic
                if JSONSerialization.isValidJSONObject(jsonDic) {
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .fragmentsAllowed)
                    let decodeValue = try JSONDecoder().decode(WeatherResponseDTO.self, from: jsonData)
                    handler(.success(decodeValue))
                }
               
            }catch{
                handler(.failure(error))
            }
            
        }.resume()
        
        
    }
    
    
}
