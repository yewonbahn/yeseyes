//
//  QRViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/25

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

class QRViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CartItemDelegate {
    public var qrstr: String = "https://yeseyes.web.app/?"
    
    @IBOutlet weak var ImageView: UIImageView!
   
    
    
    
    
    

    func updateCartItem(cell: CartListTableViewCell, quantity: Int) {
        guard let indexPath = QRTableView.indexPath(for: cell) else { return }
        guard let cartItem = cart?.items[indexPath.row] else { return }
        
        cartItem.quantity = quantity
    }
    
    var cart: Cart? = nil


    var model = [CU1Model]()



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart?.items.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CartListTableViewCell else { fatalError() }
        
        if let cartItem = cart?.items[indexPath.row]{

            cell.delegate = self as CartItemDelegate
     
            cell.itemTitle.text = cartItem.item.title
            cell.itemPrice.text = cartItem.item.price
            
            cell.countLabel.text = String(describing: cartItem.quantity)
            cell.quantity = cartItem.quantity
            
            // print(cartItem.item.title)
//            qrstr.append(cartItem.item.title+cartItem.item.price+"&")
            qrstr.append(cartItem.item.title+"&")
        }
        print(qrstr)
        self.refreshQRCode()
        return cell
    }
    

    func refreshQRCode() {
 
        let text:String = qrstr;
  
        // Generate the image
        guard let qrCode:CIImage = self.createQRCodeForString(text) else {
            print("Failed to generate QRCode")
            self.ImageView.image = nil
            return
        }
        
        // Rescale to fit the view (otherwise it is only something like 100px)
        let viewWidth = self.ImageView.bounds.size.width;
        let scale = viewWidth/qrCode.extent.size.width;
        let scaledImage = qrCode.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        // Display
        self.ImageView.image = UIImage(ciImage: scaledImage)
    }
    func createQRCodeForString(_ text: String) -> CIImage?{
        let data = text.data(using: .utf8)
        
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        // Input text
        qrFilter?.setValue(data, forKey: "inputMessage")
        // Error correction
        let values = ["L", "M", "Q", "H"]
        // Trick to limit the result to the bounds (0, array.maxIndex) - max(_MIN_, min(_value_, _MAX_))

     
        return qrFilter?.outputImage
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            cart?.updateCart(with: cart!.items[indexPath.row].getItem())
            tableView.deleteRows(at: [indexPath], with: .fade)
            qrstr="https://yeseyes.web.app/?";
            self.QRTableView.reloadData()
           
            // "Hello,world!" ??? Qr ??? ??????????????????
           
        
        } else if editingStyle == .insert {
           
            self.QRTableView.reloadData()
       
            // "Hello,world!" ??? Qr ??? ??????????????????
          
        }
    }


    var newcart = Cart()
    
    @IBOutlet weak var InputField: UITextField!
    @IBOutlet weak var QrView: UIImageView!
    @IBOutlet weak var QRTableView: UITableView!
    
    @IBAction func ProductEnter(_ sender: Any) {
        
        let title = InputField.text
        let price = " "
        let info = " "
        
        self.model.append(CU1Model(title: title as! String, price: price as! String, info: info as! String))
        
        let item = model[model.count-1]
        if(title != "") {
            cart?.updateCart(with: item)
        }
                
        qrstr="https://yeseyes.web.app/?";
        QRTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QRTableView.delegate = self
        QRTableView.dataSource = self
        self.title = "QR?????????????????"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.QRTableView.reloadData()
        // "Hello,world!" ??? Qr ??? ??????????????????
        self.refreshQRCode()
//        let QRCodeImage = generateQRCode(from:qrstr)
//        self.QrView.image = QRCodeImage
        
        print(qrstr)
   
    }
    

 
}
