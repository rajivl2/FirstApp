//
//  HomeViewController.swift
//  SnapKitPracticeApp
//
//  Created by Ford Labs on 23/07/19.
//  Copyright © 2019 Ford Labs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var cities = [String?]()
    var selectedOriginCity: String?
    var selectedDestinationCity: String?
    
    var originCityPicker: UIPickerView = {
        let origin = UIPickerView()
        origin.translatesAutoresizingMaskIntoConstraints = false
        return origin
    } ()
    
    var destinationCityPicker: UIPickerView = {
        let destination = UIPickerView()
        destination.translatesAutoresizingMaskIntoConstraints = false
        return destination
    } ()
    
    var welcomeMsg: UILabel = {
        let msg = UILabel()
        msg.text = "Welcome !"
        return msg
    }()
    
    let originCity: UILabel = {
        let msg = UILabel()
        msg.text = "Select origin City"
        msg.textAlignment = .left
        msg.layer.cornerRadius = msg.frame.size.height/2
        return msg
    } ()
    let destinationCity: UILabel = {
        let msg = UILabel()
        msg.text = "Select destination City"
        msg.textAlignment = .left
        msg.layer.cornerRadius = msg.frame.size.height/2
        return msg
    }()
    
    let dateFormatter = DateFormatter()
    let locale = NSLocale.current
    var datePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    let dateLabel: UILabel = {
        let msg = UILabel()
        msg.text = "Date"
        msg.textAlignment = .left
        msg.layer.cornerRadius = msg.frame.size.height/2
        return msg
    }()
    
    let txtDatePicker: UITextField = {
        let submit = UITextField()
        submit.placeholder = "Select Date"
        submit.backgroundColor = UIColor.clear
        //submit.setTitleColor(.black, for: .normal)
        return submit
    }()
    
    let submitButton: UIButton = {
        let submit = UIButton()
        submit.setTitle("Submit", for: .normal)
        submit.backgroundColor = .gray
        return submit
    }()
    
    var userName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false
        
        //navigationController?.navigationBar.tintColor = UIColor.clear
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Aircraft1")!)
                
        self.view.addSubview(welcomeMsg)
        welcomeMsg.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        welcomeMsg.text = "Welcome " + userName + "!"
        
        self.view.addSubview(originCity)
        originCity.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeMsg.snp.bottom).offset(80)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(200)
        }
        
        self.view.addSubview(originCityPicker)
        originCityPicker.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.equalTo(originCity.snp.right).offset(10)
            make.width.equalTo(160)
        }
        
        self.view.addSubview(destinationCity)
        destinationCity.snp.makeConstraints { (make) in
            make.top.equalTo(originCity.snp.bottom).offset(190)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(200)
        }
        
        self.view.addSubview(destinationCityPicker)
        destinationCityPicker.snp.makeConstraints { (make) in
            make.top.equalTo(originCityPicker.snp.bottom)
            make.left.equalTo(destinationCity.snp.right).offset(10)
            make.width.equalTo(160)
        }
        
        self.view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(destinationCity.snp.bottom).offset(120)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(200)
        }
        
        self.view.addSubview(txtDatePicker)
        txtDatePicker.snp.makeConstraints { (make) in
            make.top.equalTo(destinationCityPicker.snp.bottom).offset(10)
            make.width.equalTo(120)
            make.left.equalTo(dateLabel.snp.right).offset(10)
        }
        
        self.view.addSubview(submitButton)
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(txtDatePicker.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        self.originCityPicker.delegate = self
        self.destinationCityPicker.delegate = self
        
        showDatePicker()

        submitButton.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)
    }
    
    @objc func submitButtonAction(_ sender: UIButton){
        
        let origin = self.selectedOriginCity ?? ""
        let destination = self.selectedDestinationCity ?? ""
        let date = self.txtDatePicker.text ?? ""
        
        let flightTableVC = FlightsTableViewController()
        
        flightTableVC.source = origin
        flightTableVC.destination = destination
        flightTableVC.date = date
        
        self.navigationController?.pushViewController(flightTableVC, animated: true)
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtDatePicker.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.originCityPicker {
            self.selectedOriginCity = self.cities[row]
        } else {
            self.selectedDestinationCity = self.cities[row]
        }
    }
}

