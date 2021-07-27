//
//  AIViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/27.
//

import UIKit

class AICell: UITableViewCell{
    @IBOutlet weak var AILabel: UILabel!
}

struct AIModel{
    var AITitle = ""
}

class AIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = [[AIModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AICell", for: indexPath) as! AICell
        
        cell.AILabel.text = model[indexPath.section][indexPath.row].AITitle
        
        return cell
    }
    

    @IBOutlet weak var AITableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        AITableView.delegate = self
        AITableView.dataSource = self
        model.append([AIModel(AITitle: "CAM")])
    }
}
