//
//  FlightsTableViewController.swift
//  SnapKitPracticeApp
//
//  Created by Ford Labs on 24/07/19.
//  Copyright © 2019 Ford Labs. All rights reserved.
//

import UIKit

class FlightsTableViewController: UITableViewController {
    
    var results: FlightResult?
    
    var source = ""
    var destination = ""
    var date = ""
    
    let backgroundImage = UIImage(named: "Aircraft1")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        navigationController?.isNavigationBarHidden = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        let sort = UIBarButtonItem(title: "Sort Price", style: .plain, target: self, action: #selector(sortByPriceTapped))
        let showDirect = UIBarButtonItem(title: "Show Direct", style: .plain, target: self, action: #selector(showDirectFlightsTapped))
        navigationItem.setRightBarButtonItems([sort,showDirect], animated: true)
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Direct", style: .plain, target: self, action: #selector(showDirectFlightsTapped))
        
        self.navigationItem.title = "Flights"
        
        tableView.register(FlightTableViewCell.self, forCellReuseIdentifier: "cell")
        
        getFlightResults(originCity: self.source, destinationCity: self.destination, date: self.date)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let quaotes = results?.Quotes else {
            return 0
        }
        return quaotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FlightTableViewCell else {
            fatalError("Some Error Occurred ")
        }

        var price = 0.0
        var carrierId = 0
        var carrierName = ""
        price = results?.Quotes[indexPath.row].MinPrice ?? 0.0
        carrierId = results?.Quotes[indexPath.row].OutboundLeg?.CarrierIds[0] ?? 0
        cell.flightPrice.text = "Price: " + String(price)
        cell.flightName.text = "Flight Id: " + String(carrierId)
        for item in self.results!.Carriers {
            if item.CarrierId == results!.Quotes[indexPath.row].OutboundLeg?.CarrierIds[0] {
                carrierName = item.Name ?? ""
                cell.flightName.text = carrierName
            }
        }
        let direct = results?.Quotes[indexPath.row].Direct ?? false
        if direct {
            cell.directOrIndirect.text = "Non-Stop"
        } else {
            cell.directOrIndirect.text = "Stops"
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = FlightDetailsViewController()
        
        detailsVC.flightQuote = self.results?.Quotes[indexPath.row]
        guard let place = self.results?.Places else { return }
        detailsVC.flightPlace = place
        guard let carrier = self.results?.Carriers else { return }
        detailsVC.flightCarrier = carrier
        guard let currency = self.results?.Currencies else { return }
        detailsVC.currency = currency
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    func getFlightResults(originCity: String, destinationCity: String, date: String){

        let flightVM = FlightViewmodel()
        
        flightVM.getFlightDetails(originplace: originCity, destinationplace: destinationCity, date: date) { (results, error) in
            if results != nil && results?.Quotes != nil && error == nil{
                DispatchQueue.main.async {
                    self.results = results
                    self.tableView.reloadData()
                }
            } else {
                self.getDetailsScreenWithErrorMessage()
            }
        }
    }
    
    @objc func sortByPriceTapped() {
        
        self.results?.Quotes.sort (by: { $0.MinPrice! <  $1.MinPrice! })
        //self.citiesArray.sort(by: { $0 < $1 })
        self.tableView.reloadData()
    }
    
    @objc func showDirectFlightsTapped() {
        var tempResult = [Quotes]()
        guard var temp = results?.Quotes else {
            fatalError()
        }
        for i in 0..<temp.count {
            if temp[i].Direct {
                tempResult.append(temp[i])
            }
        }
        self.results?.Quotes = tempResult
        self.tableView.reloadData()
    }
    
    func getDetailsScreenWithErrorMessage(){
        let detailsVC = FlightDetailsViewController()
        detailsVC.airlineName.text = "Error"
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
