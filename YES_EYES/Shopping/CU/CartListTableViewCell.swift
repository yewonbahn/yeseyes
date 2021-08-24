//
//  CartListTableViewCell.swift
//  YES_EYES
//
//  Created by 반예원 on 2021/08/21.
//

import UIKit

protocol CartItemDelegate {
    func updateCartItem(cell: CartListTableViewCell, quantity: Int)
}

class CartListTableViewCell: UITableViewCell {

    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var reduceButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    var delegate: CartItemDelegate?
    var quantity: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        plusButton.layer.cornerRadius = 10
        plusButton.clipsToBounds = true
        
        reduceButton.layer.cornerRadius = 10
        reduceButton.clipsToBounds = true
        
        countView.layer.cornerRadius = 10
        
        plusButton.addTarget(self, action: #selector(didTabChangeCountButton(_:)), for: .touchUpInside)
        reduceButton.addTarget(self, action: #selector(didTabChangeCountButton(_:)), for: .touchUpInside)
        
    }
    
    @objc func didTabChangeCountButton(_ sender: Any) {
        if (sender as! UIButton).tag == 0 {
            quantity = quantity + 1
        } else if quantity > 0 {
            quantity = quantity - 1
        }
        
        reduceButton.isEnabled = quantity > 0
        reduceButton.backgroundColor = !reduceButton.isEnabled ? .gray : .systemIndigo
        
        self.countLabel.text = String(describing: quantity)
        self.delegate?.updateCartItem(cell: self, quantity: quantity)
    }

}
