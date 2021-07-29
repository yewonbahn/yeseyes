//
//  CUViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/29.
//

import UIKit
class CUCell : UITableViewCell{
    
    @IBOutlet weak var topLabel: UILabel!
    
}
struct CuModel{
    var mainTitle = ""
    var bottomlabel = ""

}
class CUViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var model = [[CuModel]]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    //4. numberofsections
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CUCell", for: indexPath)
        as! CUCell
        cell.topLabel.text = model[indexPath.section][indexPath.row].mainTitle
        

        return cell
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little
    @IBOutlet weak var CUTableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        CUTableView.delegate = self
        CUTableView.dataSource = self
       

        model.append([CuModel(mainTitle: "상품 정보 확인")])
    }
        
       
}
