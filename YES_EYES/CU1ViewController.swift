//
//  CUViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/29.
//

import UIKit
class CU1Cell : UITableViewCell{
    @IBOutlet weak var CU1Label: UILabel!
}

struct CU1Model{
    var mainTitle = ""
}

class CU1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var model = [[CU1Model]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CU1Cell", for: indexPath)
        as! CU1Cell
        
        cell.CU1Label.text = model[indexPath.section][indexPath.row].mainTitle
//        tableView.deselectRow(at: indexPath, animated: true)
        return cell
    }

    
    @IBOutlet weak var CU1TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CU1TableView.delegate = self
        CU1TableView.dataSource = self
        self.title = "[CU] 음료"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        model.append([CU1Model(mainTitle: "데이터를 입력해주세요.")])
    }
}
