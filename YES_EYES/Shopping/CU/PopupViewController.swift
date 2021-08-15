//
//  PopupViewController.swift
//  YES_EYES
//
//  Created by 반예원 on 2021/08/06.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var Label: UILabel!

    var strText = "nil"
    override func viewDidLoad() {
        super.viewDidLoad()
        Label.numberOfLines = 0
        Label.text = strText
        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
