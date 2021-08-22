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
    func updateCartItem(cell: CartListTableViewCell, quantity: Int) {
        guard let indexPath = QRTableView.indexPath(for: cell) else { return }
        guard let cartItem = cart?.items[indexPath.row] else { return }
        
        cartItem.quantity = quantity
        

    }
    
    var cart: Cart? = nil

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cart?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CartListTableViewCell else { fatalError() }
        
        if let cartItem = cart?.items[indexPath.section]{
            
            cell.delegate = self as CartItemDelegate
            print(cartItem.item)
            cell.itemTitle.text = cartItem.item.title
            cell.itemPrice.text = cartItem.item.price
            
            cell.countLabel.text = String(describing: cartItem.quantity)
            cell.quantity = cartItem.quantity
        }
        return cell
    }
    
    @IBOutlet weak var QrView: UIImageView!
    @IBOutlet weak var QRTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        QRTableView.delegate = self
        QRTableView.dataSource = self
        self.title = "QR·위시리스트"
        self.navigationController?.navigationBar.prefersLargeTitles = false
     
//        model.append(
//            [QRModel(wishlist: "상품이 담겼습니다.")])
//        // "Hello,world!" 가 Qr 로 형성되어있음
        //
        let QRCodeImage = generateQRCode(from: "Hello, world!")
        self.QrView.image = QRCodeImage
    }
    
 
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
      
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
            QRFilter.setValue(data, forKey: "inputMessage")
            guard let QRImage = QRFilter.outputImage else { return nil }
            
            let scaleUp = CGAffineTransform(scaleX: 10.0, y: 10.0)
            let scaledQR = QRImage.transformed(by: scaleUp)
            
            return UIImage(ciImage: scaledQR)
        }
      
        return nil
    }
}
