//
//  UserDefaults.swift
//  WeatherProject
//
//  Created by Susena on 06/04/22.
//

import Foundation

extension UserDefaults {
    
    var weatherReports : Dictionary<String, AnyObject>? {
        get{
            return UserDefaults.standard.dictionary(forKey: "weatherReports") as [String : AnyObject]?
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "weatherReports")
        }
    }
}
