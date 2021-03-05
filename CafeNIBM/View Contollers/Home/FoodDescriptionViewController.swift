//
//  FoodDescriptionViewController.swift
//  CafeNIBM
//
//  Created by Imalka Muthukumara on 2021-03-03.
//

import UIKit

class FoodDescriptionViewController: UIViewController {

    @IBOutlet weak var foodDImage: UIImageView!
    @IBOutlet weak var foodDName: UILabel!
    @IBOutlet weak var priceD: UILabel!
    @IBOutlet weak var des: UILabel!
    
    
    
    
    var selectedRow = 0
    
    var foodss = [MainFoodItems]()
     
    var setCart = [FoodCart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
//        foodName.text = foods.foodName
//        descriptionLabel.text = foods.description
//        prize.text = String(foods.prize)
//        foodImage.image = UIImage(named: foods.image)
        foodDName.text = foodss[selectedRow].foodName
        priceD.text = String(foodss[selectedRow].prize)
        des.text = foodss[selectedRow].description
        foodDImage.image = UIImage(named: foodss[selectedRow].image)
        setCart.append(FoodCart(id: 1, foodName: "dd", qty: 23, prize: 234))
    }
    
    @IBAction func orderButton(_ sender: Any) {
        //setCart.append(FoodCart(id: 1, foodName: "GG", qty: 1, prize: 2))
        
        performSegue(withIdentifier: "toHomeVc", sender: nil)
        
        let vc = HomeViewController(nibName: "CartTableViewCell", bundle: nil)
       

        navigationController?.popViewController(animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toHomeVc" {
            
            let destinayionVC  = segue.destination as! HomeViewController
            //destinayionVC.selectedRow = myIndex
            destinayionVC.cartitemshome = setCart
        }
        
    }
    

}
