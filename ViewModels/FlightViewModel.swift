//
//  FlightViewModel.swift
//  SnapKitPracticeApp
//
//  Created by Ford Labs on 24/07/19.
//  Copyright © 2019 Ford Labs. All rights reserved.
//

import Foundation

class FlightViewmodel {
    
    let headers = ["X-RapidAPI-Host" : "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com", "X-RapidAPI-Key" : "afcfda65dbmsh367f130bb6c22a2p1f2c6ajsn7de0bf8102f7"]
    
    func getFlightDetails(originplace: String, destinationplace: String, date: String, completion: @escaping(_ report : FlightResult?, Error?)->Void ) {
        
        let country = "US"
        let locale = "en-US"
        let currency = "INR"
        
        var flightResults: FlightResult?
        
        let urlString = "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browseroutes/v1.0/\(country)/\(currency)/\(locale)/\(originplace)/\(destinationplace)/\(date)"
        guard let url = URL(string: urlString) else { fatalError("Error while parsing url") }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                flightResults = try JSONDecoder().decode(FlightResult.self, from: data)
                completion(flightResults, nil)
            } catch let apiError {
                completion(nil, apiError)
                print(apiError)
            }
            }.resume()
    }
    
    func getPlaces(completionHandler: @escaping(_ report: PlaceResults?, Error?) -> Void){
        let country = "IND"
        let locale = "en-US"
        let currency = "INR"
        let place = "india"
        var places: PlaceResults?
        
        let urlString = "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/\(country)/\(currency)/\(locale)/?query=\(place)"
        guard let url = URL(string: urlString) else { fatalError("Error while parsing url") }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                places = try JSONDecoder().decode(PlaceResults.self, from: data)
                completionHandler(places, nil)
            } catch let apiError {
                completionHandler(nil, apiError)
                print(apiError)
            }
            }.resume()
    }
}
