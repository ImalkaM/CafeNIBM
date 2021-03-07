//
//  CartTableViewCell.swift
//  CafeNIBM
//
//  Created by Imalka Muthukumara on 2021-03-03.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    var actionBlockPlus: (() -> Void)? = nil
    
    var actionBlockMinus: (() -> Void)? = nil
    
    var qty: Int = 1
    var priceFinal: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        
        actionBlockPlus?()
    }
    
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        actionBlockMinus?()
    }
    
    
    func set(cartItems: FoodCart){
        
        
        foodName.text = cartItems.foodName
        qtyLabel.text = String(qty)
        //priceFinal = cartItems.price
        priceLabel.text = String(cartItems.finalPrice)
        
       
       
    } 
}
