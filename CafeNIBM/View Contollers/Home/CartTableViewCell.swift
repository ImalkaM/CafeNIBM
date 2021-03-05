//
//  CartTableViewCell.swift
//  CafeNIBM
//
//  Created by Imalka Muthukumara on 2021-03-03.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var foodName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(cartItems: FoodCart){
        
        foodName.text = cartItems.foodName
       
    } 
}
