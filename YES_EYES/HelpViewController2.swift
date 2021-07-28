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

   
    @IBOutlet weak var helpTableView2: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        helpTableView2.delegate = self
        helpTableView2.dataSource = self
       

        model.append(HelpModel2(mainTitle: "메인화면 전환 안내",bottomlabel: "상품을 클릭하여주세요"))
        
       
    }
    

}

