//
//  LogInViewController.swift
//  SnapKitPracticeApp
//
//  Created by Ford Labs on 23/07/19.
//  Copyright © 2019 Ford Labs. All rights reserved.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {

    var cities = [String?]()
    
    let userName: UITextField = {
        let name = UITextField()
        name.placeholder = "Enter Username ... "
        name.addShadowToTextField(cornerRadius: 3)
        name.addShadowToTextField(color: UIColor.black, cornerRadius: 3)
        return name
    } ()
    let password: UITextField = {
        let password = UITextField()
        password.placeholder = "Enter Password ... "
        password.addShadowToTextField(cornerRadius: 3)
        password.addShadowToTextField(color: UIColor.black, cornerRadius: 3)
        return password
    }()
    let logInButton: UIButton = {
        let logIn = UIButton()
        logIn.setTitle("Log In", for: .normal)
        logIn.backgroundColor = .blue
        return logIn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        loadCities()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Aircraft1")!)
        
        self.view.addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(160)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        self.view.addSubview(password)
        password.snp.makeConstraints { (make) in
            make.top.equalTo(userName.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        self.view.addSubview(logInButton)
        logInButton.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        logInButton.addTarget(self, action: #selector(logInButtonAction), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if animated {
            navigationController?.isNavigationBarHidden = true
        }
    }

    @objc func logInButtonAction(_ sender: UIButton){
        
        let homeVC = HomeViewController()
        homeVC.userName = userName.text ?? ""
        homeVC.cities = self.cities
        
        
        
        self.navigationController?.pushViewController(homeVC, animated: true)
        
    }
    
    func loadCities(){
        let flightVM = FlightViewmodel()
        
        flightVM.getPlaces { (data, error) in
            let cityCount = data?.Places.count ?? 0
            for i in 0..<cityCount {
                self.cities.append(data?.Places[i]?.PlaceId)
            }
        }
    }
    
}

extension UITextField {
    
    func addShadowToTextField(color: UIColor = UIColor.gray, cornerRadius: CGFloat) {
        
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1.0
        self.backgroundColor = .white
        self.layer.cornerRadius = cornerRadius
    }
}

