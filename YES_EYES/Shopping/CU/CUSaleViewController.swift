//
//  CUSaleViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/08/05.
//
// Discount/Total page

import UIKit

class SaleCell: UITableViewCell{
    @IBOutlet weak var saleLabel: UILabel!
}

struct SaleModel{
    var saleTitle = ""
}

class CUSaleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = [[SaleModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaleCell", for: indexPath) as! SaleCell
        
        cell.saleLabel.text = model[indexPath.section][indexPath.row].saleTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0{
            if let CUVC = UIStoryboard(name: "CUViewController", bundle: nil).instantiateViewController(identifier: "CUViewController") as? CUViewController{
                self.navigationController?.pushViewController(CUVC, animated: true)
            }
        }
        
        else if indexPath.section == 0 && indexPath.row == 1{
            if let CUtVC = UIStoryboard(name: "CUSearchViewController", bundle: nil).instantiateViewController(identifier: "CUSearchViewController") as? CUSearchViewController{
                self.navigationController?.pushViewController(CUtVC, animated: true)
            }
        }
    }

    @IBOutlet weak var saleTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CU"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        saleTableView.delegate = self
        saleTableView.dataSource = self
        saleTableView.backgroundColor = UIColor(displayP3Red: 228/255, green: 231/255, blue: 246/255, alpha:0)
        
        model.append([
        SaleModel(saleTitle: "할인 상품"),
        SaleModel(saleTitle: "상품 검색")])
    }
}
