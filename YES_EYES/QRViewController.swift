//
//  QRViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/25.
//

import UIKit

class QRCell: UITableViewCell{
    
    @IBOutlet weak var wishlistTitle: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
//    {
//        didSet{
//            rightImageView.image = UIImage.init(systemName: "trash")
//        }
//    }
}

struct QRModel{
    var wishlist = ""
}

class QRViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = [[QRModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QRCell", for: indexPath) as! QRCell
        
        cell.wishlistTitle.text = model[indexPath.section][indexPath.row].wishlist
        
        return cell
    }
    

    @IBOutlet weak var QRTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        QRTableView.delegate = self
        QRTableView.dataSource = self
        
        model.append(
            [QRModel(wishlist: "상품이 담겼습니다.")])
    }
}
