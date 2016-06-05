//
//  ForcastCell.swift
//  Minimalist-Weather
//
//  Created by Jeremy Burnham on 6/3/16.
//  Copyright © 2016 Jeremy Burnham. All rights reserved.
//

import UIKit

class ForcastCell: UICollectionViewCell {
    
    @IBOutlet weak var forcastImg: UIImageView!
    @IBOutlet weak var temp: UILabel!
    
    var forcast: Forcast!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configurecCell(row: Int) {
       
        if  temperaturs.count > 1 {
            temp.text = temperaturs[row]
            forcastImg.image = UIImage(named: icons[row])
        } else {
            temp.text = ""
            forcastImg.image = UIImage(named: "")
        }
    }

}
