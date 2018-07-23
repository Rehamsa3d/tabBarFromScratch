//
//  ViewController.swift
//  tabBarFromScratch
//
//  Created by cems ios on 7/23/18.
//  Copyright © 2018 cems ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var items:[CellInfo] = []
    
    var cell:TableViewCell?

    var array1:Array<CellInfo> = []
    var array2:Array<CellInfo> = []
    var array3:Array<CellInfo> = []
    
    
    let buttonBar = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        handleRefresh()
        customSegmentControll()
    }
    
    
    
    func setData() {
        
        let count = items.count
        
        let firstCount = count / 2
        
        for (i,x) in items.enumerated() {
            if i <= firstCount {
                array1.append(x)
                
            }else if i % 2 == 0 {
                array2.append(x)
            }else {
                array3.append(x)
            }
        }
  
    }
    //handleRefresh
    private func handleRefresh() {
        
        API.getSquare() { (error : Error?, data : [CellInfo]?,json) in
            
            if let data = data {
            
                self.items = data
                self.tableView.reloadData()
                self.setData()
            }
            
        }
        
    }

    
    
//    //Mark:segmentedControl Action
    @IBAction func indexChanged(_ sender: AnyObject) {

        DispatchQueue.main.async {
            
            switch self.segmentedControl.selectedSegmentIndex
            {
            case 0:
                
                self.items = self.array1
                self.tableView.reloadData()

            case 1:
                self.items = self.array2
                self.tableView.reloadData()

            case 2:
                self.items = self.array3
                self.tableView.reloadData()

            default:
                break
            }
            
        }
    }



}

//extension for UITableView
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        TableViewCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell {
            
            let item = items[indexPath.row]
            cell.config(with: item)
            
            switch self.segmentedControl.selectedSegmentIndex
            {
            case 0:
                cell.wait()
                return cell
              
            case 1:
                cell.accepted()
                return cell

            case 2:
                cell.canceld()
                return cell

            default:
                break
            }
            
        }
        return UITableViewCell()
    }
}

extension ViewController {
    func customSegmentControll(){
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        
        // Add lines below the segmented control's tintColor
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedStringKey.foregroundColor: UIColor.orange
            ], for: .selected)
        
        // This needs to be false since we are using auto layout constraints
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor.orange
        
        view.addSubview(buttonBar)
        
        // Constrain the top of the button bar to the bottom of the segmented control
        buttonBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 3).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)).isActive = true
        
        segmentedControl.addTarget(self, action: #selector(self.segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
        }
    }
}
