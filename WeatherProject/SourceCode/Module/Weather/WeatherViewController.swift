//
//  WeatherViewController.swift
//  WeatherProject
//
//  Created by Susena on 06/04/22.
//

// Used MVC pattern
// I am only getting 3 days from the api you provided. If its updated its dynamically change

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK:- Oulet Properties
    
    var loader: UIActivityIndicatorView?
    var tableView  = UITableView(frame: .zero)
    let lblCity    = UILabel(frame: .zero)
    let lblCountry = UILabel(frame: .zero)
    let lblDate    = UILabel(frame: .zero)
    //MARK:- Custom Properties
    private let CELL_IDENTIFIER = "WeatherCell"
    private var model = WeatherModel()
    
    private var forecastday : [Forecastday] = []
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        model.delegate = self
        
        // Check data in local and display. Also get data from server and updating from background
        if let reportsDic =  UserDefaults.standard.weatherReports {
            do {
                if JSONSerialization.isValidJSONObject(reportsDic) {
                    let jsonData = try JSONSerialization.data(withJSONObject: reportsDic, options: .fragmentsAllowed)
                    let decodeValue = try JSONDecoder().decode(WeatherResponseDTO.self, from: jsonData)
                    getReportSuccessfully(response: decodeValue)
                }
               
            }catch{
                debugPrint(error.localizedDescription)
            }
        
        }else{
            showLoader()
        }
        model.getReport()
                
    }

    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.layoutIfNeeded()
            self?.tableView.endUpdates()
            self?.tableView.reloadData()
        }
        
    }
    
    //MARK:- Custom Methods -
    
    
    private func showLoader(){
        if let loader = loader{
            loader.startAnimating()
        } else {
            loader = UIActivityIndicatorView(style: .large)
            loader?.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            loader?.center = view.center
            loader?.color = UIColor.blue
            view.addSubview(loader!)
            loader?.startAnimating()
        }

        
    }

    private func removeLoader(){
        guard let loader = loader else {
            return
        }
        loader.stopAnimating()
    }

    
    private func addInformation(city: String, country: String, date: String){
        
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblCity.translatesAutoresizingMaskIntoConstraints = false
        lblCountry.translatesAutoresizingMaskIntoConstraints = false
        
        lblCity.textColor = UIColor.darkGray
        lblCity.font = lblCity.font.withSize(20)
        lblCity.text = city
        lblCity.numberOfLines = 0
        lblCity.sizeToFit()
        lblCity.textAlignment = .center
        self.view.addSubview(lblCity)
        
        lblCountry.textColor = UIColor.darkGray
        lblCountry.font = lblCountry.font.withSize(20)
        lblCountry.text = country
        lblCountry.numberOfLines = 0
        lblCountry.sizeToFit()
        lblCountry.textAlignment = .center
        self.view.addSubview(lblCountry)
        
        lblDate.textColor = UIColor.black
        lblDate.font = lblDate.font.withSize(20)
        lblDate.text = model.getCurrentDateToShow(dateString: date)
        lblDate.textAlignment = .center
        lblDate.numberOfLines = 0
        lblDate.sizeToFit()
        self.view.addSubview(lblDate)
        
        NSLayoutConstraint.activate([
            lblDate.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            lblDate.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            lblDate.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            lblCity.topAnchor.constraint(equalTo: lblDate.bottomAnchor, constant: 15),
            lblCity.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
        ])
        
        NSLayoutConstraint.activate([
            lblCountry.topAnchor.constraint(equalTo: lblCity.bottomAnchor, constant: 6),
            lblCountry.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
//            lblCountry.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
        
    }
    
    
    
    private func addWeatherinfo(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFIER)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.separatorColor = UIColor.clear
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: lblCountry.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
        ])
    }

}


//MARK:- WeatherModelDelegate

extension WeatherViewController: WeatherModelDelegate {
  
    func getReportSuccessfully(response: WeatherResponseDTO) {
        DispatchQueue.main.async { [weak self] in
            self?.removeLoader()
            self?.addInformation(city: response.location?.name ?? "", country: response.location?.country ?? "", date: response.location?.localtime ?? "")
            self?.forecastday = response.forecast?.forecastday ?? []
            self?.addWeatherinfo()
            self?.tableView.reloadData()
        }
    }
    
    func onFailure(error: Error) {
        DispatchQueue.main.async { [weak self] in 
            self?.removeLoader()
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
}


//MARK:- UITableViewDataSource

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastday.count
    }
//cdn.weatherapi.com/weather/64x64/day/113.png
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! WeatherTableViewCell
        cell.lblDate.text = model.getDateToShow(dateString: forecastday[indexPath.row].date)
        cell.lblCondition.text = forecastday[indexPath.row].day?.condition?.text ?? ""
        cell.lblMaxTemp.text = String(describing: forecastday[indexPath.row].day!.maxtemp_c!) + "°C"
        cell.lblMinTemp.text = String(describing: forecastday[indexPath.row].day!.mintemp_c!) + "°C"
        if let urlString = forecastday[indexPath.row].day?.condition?.icon, let url = URL(string: "http:" + urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
            
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async { [weak cell] in
                    cell?.imgWeather.image = UIImage(data: data)
                }
            }.resume()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    

   
}
