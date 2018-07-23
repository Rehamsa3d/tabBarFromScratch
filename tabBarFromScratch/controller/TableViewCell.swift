//
//  TableViewCell.swift
//  tabBarFromScratch
//
//  Created by cems ios on 7/23/18.
//  Copyright © 2018 cems ios. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //Mark:Properities
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var canceled: UIButtonX!
    @IBOutlet weak var ok: UIButtonX!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //config
    func config(with data:CellInfo){
        Label.text = data.lable
    }
    

    func wait(){
        ok.isHidden = false
        canceled.isHidden = false

    }
    func accepted(){
        ok.isHidden = true
        canceled.isHidden = false

    }
    func canceld(){
        ok.isHidden = false
        canceled.isHidden = true

        

    }


}
