//
//  CUViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/27.
//

import UIKit

//2. storecell - class, identifier
class CUCell: UITableViewCell{
    @IBOutlet weak var CULabel: UILabel!
}

//3. model
struct CUModel{
    var CUTitle = ""
}

class CUViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = [[CUModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    //4. numberofsections
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CUCell", for: indexPath) as! CUCell
        
        cell.CULabel.text = model[indexPath.section][indexPath.row].CUTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //1. view class connection
    @IBOutlet weak var CUTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CUTableView.delegate = self
        CUTableView.dataSource = self
        CUTableView.backgroundColor = UIColor(displayP3Red: 228/255, green: 231/255, blue: 246/255, alpha:0)
        
        model.append([
        CUModel(CUTitle: "음료"),
        CUModel(CUTitle: "과자"),
        CUModel(CUTitle: "아이스크림"),
        CUModel(CUTitle: "간편식사"),
        CUModel(CUTitle: "즉석조리"),
        CUModel(CUTitle: "식품"),
        CUModel(CUTitle: "생활용품")])
    }
}

/*
 1. view class connection
 2. storecell - class, identifier
 3. model
 4. numberofsections
 5. (ViewController) - didselectrowat
 */
