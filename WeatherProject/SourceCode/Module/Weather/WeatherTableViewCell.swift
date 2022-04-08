//
//  WeatherTableViewCell.swift
//  WeatherProject
//
//  Created by Susena on 06/04/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    //MARK:- Oulet Properties
    
    let lblDate = UILabel(frame: .zero)
    let lblCondition = UILabel(frame: .zero)
    let lblMaxTemp = UILabel(frame: .zero)
    let lblMinTemp = UILabel(frame: .zero)
    let imgWeather = UIImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblCondition.translatesAutoresizingMaskIntoConstraints = false
        lblMaxTemp.translatesAutoresizingMaskIntoConstraints = false
        lblMinTemp.translatesAutoresizingMaskIntoConstraints = false
        imgWeather.translatesAutoresizingMaskIntoConstraints = false
        
        lblDate.textColor = UIColor.black
        lblDate.font = lblDate.font.withSize(16)
        lblDate.textAlignment = .center
        lblDate.numberOfLines = 0
        lblDate.sizeToFit()
        contentView.addSubview(lblDate)
        
        lblCondition.textColor = UIColor.darkGray
        lblCondition.font = lblCondition.font.withSize(16)
        lblCondition.textAlignment = .center
        lblCondition.numberOfLines = 0
        lblCondition.sizeToFit()
        contentView.addSubview(lblCondition)
        
        lblMaxTemp.textColor = UIColor.red
        lblMaxTemp.font = lblMaxTemp.font.withSize(16)
        lblMaxTemp.textAlignment = .right
        lblMaxTemp.numberOfLines = 0
        lblMaxTemp.sizeToFit()
        contentView.addSubview(lblMaxTemp)
        
        lblMinTemp.textColor = UIColor.blue
        lblMinTemp.font = lblMinTemp.font.withSize(16)
        lblMinTemp.textAlignment = .left
        lblMinTemp.numberOfLines = 0
        lblMinTemp.sizeToFit()
        contentView.addSubview(lblMinTemp)
        
        contentView.addSubview(imgWeather)
        
    
        
        NSLayoutConstraint.activate([
            lblDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            lblDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            imgWeather.widthAnchor.constraint(equalToConstant: 40),
            imgWeather.heightAnchor.constraint(equalToConstant: 40),
            imgWeather.topAnchor.constraint(equalTo: lblDate.bottomAnchor, constant: 5),
            imgWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            lblCondition.centerYAnchor.constraint(equalTo: imgWeather.centerYAnchor, constant: 0),
            lblCondition.leadingAnchor.constraint(equalTo: imgWeather.trailingAnchor, constant: 5),
            lblCondition.trailingAnchor.constraint(equalTo: lblMaxTemp.leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            lblMinTemp.centerYAnchor.constraint(equalTo: imgWeather.centerYAnchor, constant: 0),
            lblMinTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            lblMaxTemp.centerYAnchor.constraint(equalTo: imgWeather.centerYAnchor, constant: 0),
            lblMaxTemp.trailingAnchor.constraint(equalTo: lblMinTemp.leadingAnchor, constant: -15)
            
        ])
        
       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblDate.text = ""
        lblCondition.text = ""
        lblMinTemp.text = ""
        lblMaxTemp.text = ""
        imgWeather.image = nil
    }

}
