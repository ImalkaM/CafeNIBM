//
//  FoodDescriptionViewController.swift
//  CafeNIBM
//
//  Created by Imalka Muthukumara on 2021-03-03.
//

import UIKit
import Firebase

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
        //setCart.append(FoodCart(id: selectedRow, foodName: foodss[selectedRow].foodName, qty: 1, prize: foodss[selectedRow].prize))
    }
    
    @IBAction func orderButton(_ sender: Any) {
        //setCart.append(FoodCart(id: 1, foodName: "GG", qty: 1, prize: 2))
        
        performSegue(withIdentifier: "toHomeVc", sender: nil)
        
        setCartData()
        
//        let vc = HomeViewController(nibName: "CartTableViewCell", bundle: nil)
//
//        vc.cartTable.reloadData()
//
//        navigationController?.pushViewController(HomeViewController, animated: true)
        
    }
    
    func setCartData() {
        
        let fireStoreDB = Firestore.firestore()
        
        fireStoreDB.collection("cartTable").addDocument(data: [
            "name": foodss[selectedRow].foodName,
            "qty": 1,
            "price": foodss[selectedRow].prize,
            "finalPrice": foodss[selectedRow].prize,
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "toHomeVc" {
//            
//            let destinayionVC  = segue.destination as! HomeViewController
//            //destinayionVC.selectedRow = myIndex
//        }
//        
//    }
    

}
