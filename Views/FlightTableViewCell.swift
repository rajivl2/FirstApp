//
//  FlightTableViewCell.swift
//  SnapKitPracticeApp
//
//  Created by Ford Labs on 24/07/19.
//  Copyright © 2019 Ford Labs. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var flightName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    var flightPrice: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    var directOrIndirect: UILabel = {
        let direct = UILabel()
        direct.translatesAutoresizingMaskIntoConstraints = false
        return direct
    }()
    
    func setUpViews(){
        addSubview(flightName)
        flightName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(130)
            make.left.equalTo(20)
        }
        
        addSubview(flightPrice)
        flightPrice.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(flightName.snp.right)
            make.width.equalTo(130)
        }
        
        addSubview(directOrIndirect)
        directOrIndirect.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(flightPrice.snp.right)
            make.width.equalTo(130)
        }
    }
}
