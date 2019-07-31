//
//  FlightDetailsViewController.swift
//  SnapKitPracticeApp
//
//  Created by Ford Labs on 24/07/19.
//  Copyright © 2019 Ford Labs. All rights reserved.
//

import UIKit

class FlightDetailsViewController: UIViewController {

    var airlineName: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 25)
        name.text = "No Data Found !"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    var dateTime: UILabel = {
       let date = UILabel()
        date.font = UIFont.boldSystemFont(ofSize: 20)
        date.text = "No Data Found !"
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    var price: UILabel = {
        let price = UILabel()
        price.font = UIFont.boldSystemFont(ofSize: 25)
        price.text = "No Data Found !"
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    var direct: UILabel = {
        let direct = UILabel()
        direct.font = UIFont.boldSystemFont(ofSize: 25)
        direct.text = "No Data Found !"
        direct.translatesAutoresizingMaskIntoConstraints = false
        return direct
    }()
    
    var flightQuote : Quotes?
    var flightPlace = [Places]()
    var flightCarrier = [Carriers]()
    var currency = [Currencies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Aircraft")!)
        
        addLabels()
        
    }
    
    func addLabels(){
        self.view.addSubview(airlineName)
        airlineName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(160)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
        if airlineName.text! == "Error" {
            airlineName.text = "No data found !"
        } else {
            self.view.addSubview(dateTime)
            dateTime.snp.makeConstraints { (make) in
                make.top.equalTo(airlineName.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
                make.width.equalTo(250)
            }
            self.view.addSubview(price)
            price.snp.makeConstraints { (make) in
                make.top.equalTo(dateTime.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
                make.width.equalTo(250)
            }
        
            self.view.addSubview(direct)
            direct.snp.makeConstraints { (make) in
                make.top.equalTo(price.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
                make.width.equalTo(250)
            }
            
            showDetails()
        }
    }

    func showDetails(){
        var minPrice = 0.0
        var direct = ""
        for airline in self.flightCarrier{
            if airline.CarrierId == self.flightQuote?.OutboundLeg?.CarrierIds[0] {
                self.airlineName.text = airline.Name
            }
        }
        minPrice = self.flightQuote?.MinPrice ?? 0.0
        direct = self.flightQuote?.Direct.description ?? "None"
        self.dateTime.text = self.flightQuote?.QuoteDateTime
        self.price.text = "Price: " + self.currency[0].Code! + " " + String(minPrice)
        self.direct.text = "Direct Flight: " + direct
    }
}
