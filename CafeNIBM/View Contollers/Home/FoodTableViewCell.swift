//
//  FoodTableViewCell.swift
//  CafeNIBM
//
//  Created by Imalka Muthukumara on 2021-03-01.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var foodName: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var prize: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
    }
    
    func set(foods: MainFoodItems){
        
        foodName.text = foods.foodName
        descriptionLabel.text = foods.description
        prize.text = String(foods.prize)
        foodImage.image = UIImage(named: foods.image)
    }
    
}
