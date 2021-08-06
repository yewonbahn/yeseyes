//
//  CUSearchViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/08/05.
//
// CU_Search

import UIKit
import FirebaseDatabase

class CUSearchCell : UITableViewCell{
    @IBOutlet weak var topLabel: UILabel!
}

struct CUModel{
    var title = ""
    var price = ""
    var info = ""
}

class CUSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = [[CUModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        as! ItemCell
        
        cell.Title.text = model[indexPath.section][indexPath.row].title
        cell.Price.text = model[indexPath.section][indexPath.row].price
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        if indexPath.section == 0 && indexPath.row == 0{
//            if let CU1VC = UIStoryboard(name: "CU1ViewController", bundle: nil).instantiateViewController(identifier: "CU1ViewController") as? CU1ViewController{
//                self.navigationController?.pushViewController(CU1VC, animated: true)
//            }
//        }
//    }
//
    @IBOutlet weak var CUSearchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CUSearchTableView.delegate = self
        CUSearchTableView.dataSource = self
        
        self.title = "[CU] 상품 검색"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        CUSearchTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell") // ItemCell xib 등록
        
        
        let ref: DatabaseReference! = Database.database().reference()
        // var handle: DatabaseHandle!
        
        ref.child("cu").child("instant").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                
                let item = snap.value as! [String: Any]
                
                let title = item["title"] ?? ""
                let price = item["price"] ?? ""
                let info = item["info"] ?? ""
                
                self.model.append([CUModel(title: title as! String, price: price as! String, info: info as! String)])
            }
            self.CUSearchTableView.reloadData()
        }
    }
}
