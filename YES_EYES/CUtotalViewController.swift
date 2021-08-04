//
//  CUtotalViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/08/05.
//

import UIKit
class CUtCell : UITableViewCell{
    @IBOutlet weak var topLabel: UILabel!
}

struct CUModel{
    var mainTitle = ""
    var bottomlabel = ""
}

class CUtotalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var model = [[CUModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CUtCell", for: indexPath)
        as! CUtCell
        
        cell.topLabel.text = model[indexPath.section][indexPath.row].mainTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0{
            if let CU1VC = UIStoryboard(name: "CU1ViewController", bundle: nil).instantiateViewController(identifier: "CU1ViewController") as? CU1ViewController{
                self.navigationController?.pushViewController(CU1VC, animated: true)
            }
        }
        
        if indexPath.section == 0 && indexPath.row == 1{
            if let CU1VC = UIStoryboard(name: "CU1ViewController", bundle: nil).instantiateViewController(identifier: "CU1ViewController") as? CU1ViewController{
                self.navigationController?.pushViewController(CU1VC, animated: true)
            }
        }
        
        if indexPath.section == 0 && indexPath.row == 2{
            if let CU1VC = UIStoryboard(name: "CU1ViewController", bundle: nil).instantiateViewController(identifier: "CU1ViewController") as? CU1ViewController{
                self.navigationController?.pushViewController(CU1VC, animated: true)
            }
        }
        
        if indexPath.section == 0 && indexPath.row == 3{
            if let CU1VC = UIStoryboard(name: "CU1ViewController", bundle: nil).instantiateViewController(identifier: "CU1ViewController") as? CU1ViewController{
                self.navigationController?.pushViewController(CU1VC, animated: true)
            }
        }
        
        if indexPath.section == 0 && indexPath.row == 4{
            if let CU1VC = UIStoryboard(name: "CU1ViewController", bundle: nil).instantiateViewController(identifier: "CU1ViewController") as? CU1ViewController{
                self.navigationController?.pushViewController(CU1VC, animated: true)
            }
        }
        
        if indexPath.section == 0 && indexPath.row == 5{
            if let CU1VC = UIStoryboard(name: "CU1ViewController", bundle: nil).instantiateViewController(identifier: "CU1ViewController") as? CU1ViewController{
                self.navigationController?.pushViewController(CU1VC, animated: true)
            }
        }
        
        if indexPath.section == 0 && indexPath.row == 6{
            if let CU1VC = UIStoryboard(name: "CU1ViewController", bundle: nil).instantiateViewController(identifier: "CU1ViewController") as? CU1ViewController{
                self.navigationController?.pushViewController(CU1VC, animated: true)
            }
        }
        
        if indexPath.section == 0 && indexPath.row == 7{
            if let CU1VC = UIStoryboard(name: "CU1ViewController", bundle: nil).instantiateViewController(identifier: "CU1ViewController") as? CU1ViewController{
                self.navigationController?.pushViewController(CU1VC, animated: true)
            }
        }
    }

    @IBOutlet weak var CUtTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CUtTableView.delegate = self
        CUtTableView.dataSource = self
        
        self.title = "[CU] 전체 상품"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        model.append([
                CUModel(mainTitle: "음료"),
                CUModel(mainTitle: "과자"),
                CUModel(mainTitle: "아이스크림"),
                CUModel(mainTitle: "간편식사"),
                CUModel(mainTitle: "즉석조리"),
                CUModel(mainTitle: "식품"),
                CUModel(mainTitle: "생활용품")])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
