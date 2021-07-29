import UIKit
class HelpCell3: UITableViewCell{
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var centerImageView: UIImageView!
}
struct HelpModel3{
    var mainTitle = ""
    var bottomlabel = ""

}
class HelpViewController3: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var model = [HelpModel3]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpCell3", for: indexPath)
        as! HelpCell3
        cell.topLabel.text = model[indexPath.section].mainTitle
        
        cell.bottomLabel.text = model[indexPath.section].bottomlabel
        return cell
    }

   
    @IBOutlet weak var helpTableView3: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        helpTableView3.delegate = self
        helpTableView3.dataSource = self
       

        model.append(HelpModel3(mainTitle: "상품 정보 확인",bottomlabel: "두 손가락을 이용하여 왼쪽으로 스와이프 해주세요"))
        
       
    }
    

}

