import UIKit
class HelpCell2: UITableViewCell{
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var centerImageView: UIImageView!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
}
struct HelpModel2{
    var mainTitle = ""
    var bottomlabel = ""
    
}
class HelpViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var model = [HelpModel2]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpCell2", for: indexPath)
        as! HelpCell2
        cell.topLabel.text = model[indexPath.section].mainTitle
        
        cell.bottomLabel.text = model[indexPath.section].bottomlabel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if let HelpVC3 = UIStoryboard(name: "HelpViewController3", bundle: nil).instantiateViewController(identifier: "HelpViewController3") as? HelpViewController3{
                self.navigationController?.pushViewController(HelpVC3, animated: true)
            }
          
        }

    }
   
    @IBOutlet weak var helpTableView2: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        helpTableView2.delegate = self
        helpTableView2.dataSource = self
       

        model.append(HelpModel2(mainTitle: "위시리스트에 상품 추가/삭제",bottomlabel: "화면을 더블클릭해주세요"))
        
       
    }
    

}

