//
//  WeatherModel.swift
//  WeatherProject
//
//  Created by Susena on 06/04/22.
//

import Foundation

protocol WeatherModelDelegate: AnyObject {
    func getReportSuccessfully(response: WeatherResponseDTO)
    func onFailure(error: Error)
}

struct WeatherModel {
    
    weak var delegate: WeatherModelDelegate?
    
//    var response : WeatherResponseDTO?
    
    // We can change the city property get the weather of required cities
    public let city = "Chennai"
    
    mutating func getReport(){
        
        var dataHandler = WeatherDataHandler()
        
        let modelSelf = self
        
        dataHandler.getWeatherReports(city: city) { result in
            
            switch result{
            case .success(let response):
//                modelSelf.response = response
                modelSelf.delegate?.getReportSuccessfully(response: response)
            case .failure(let error):
                modelSelf.delegate?.onFailure(error: error)
            }
        }
    }
    
    
    // get current date to show in Days
        
    public func getCurrentDateToShow(dateString: String?) -> String {
        guard let dateString = dateString else {
            return ""
        }
        return convertDate(dateString: dateString, currentFromate: "yyyy-MM-dd HH:mm", requireFormat: "EEEE, MMM d, yyyy   h:mm a")
    }

    
    //get Date to show in Days
    
    public func getDateToShow(dateString: String?) -> String {
        guard let dateString = dateString else {
            return ""
        }
        return convertDate(dateString: dateString, currentFromate: "yyyy-MM-dd", requireFormat: "EEEE, MMM d, yyyy")
    }
    
    // convert the date to require format
    private func convertDate(dateString: String, currentFromate: String, requireFormat: String) -> String{
        let formater = DateFormatter()
        formater.dateFormat = currentFromate
        let date = formater.date(from: dateString)
        formater.dateFormat = requireFormat
        return formater.string(from: date!)
    }
}
