//
//  HomeViewController.swift
//  CafeNIBM
//
//  Created by Imalka Muthukumara on 2021-02-28.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var foodTable: UITableView!
    @IBOutlet weak var cartTable: UITableView!
    
    var foods = [MainFoodItems]()
    
    var selectedRow = 0
    
    var indexPathCartcell = IndexPath()
    
    var cartitemshome = [FoodCart](){
        didSet {
             cartTable.reloadData()
            }
    }
//    var tableViewData: [Roster] = [] {
//     didSet {
//      rosterTable.reloadData()
//     }
//    }
    
    var myIndex = 0
    
    var selectedCartItem = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        
        
        let cellNibFoodTable = UINib(nibName: "FoodTableViewCell", bundle: nil)
        foodTable.register(cellNibFoodTable, forCellReuseIdentifier: "foodCell")
        
        //to remove unnecessary rows
        foodTable.tableFooterView = UIView()
        //foodTable.reloadData()
        
        let cellNibCartTable = UINib(nibName: "CartTableViewCell", bundle: nil)
        cartTable.register(cellNibCartTable, forCellReuseIdentifier: "cartCell")
        cartTable.tableFooterView = UIView()
        
        
        
        foodTable.delegate = self
        foodTable.dataSource = self
        
        cartTable.delegate = self
        cartTable.dataSource = self
        
        getDataFoodTable()
        //self.getCartTable()
        //getCartTable()
        //cartitemshome.append(FoodCart(id: 1, foodName: "ede", qty: 2, prize: 23)
        
        
        // Do any additional setup after loading the view.
        //print(foods)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getCartTable()
       // self.cartTable.reloadData()
    }
    
    func getDataFoodTable(){
        let fireStoreDB = Firestore.firestore()
        
        fireStoreDB.collection("foods").addSnapshotListener { (snapshot, err) in
            if err != nil {
                print(err?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true {
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        //print(documentID)
                        
                        let foodName =  document.get("name")
                        let des = document.get("description")
                        let prize = document.get("prize")
                        let imageString = document.get("image")
                        // var foodName = document.get("name")
                        
                        if let foodName = document.get("name") as? String {
                            self.foods.append(MainFoodItems(id: 1, image: imageString as! String, foodName: foodName, description: des as! String, prize: prize as! Int))
                        }
                    }
                    self.foodTable.reloadData()
                    // self.cartTable.reloadData()
                }
            }
        }
    }
    
    func getCartTable(){
        
        let fireStoreDB = Firestore.firestore()

        fireStoreDB.collection("cartTable").addSnapshotListener { (snapshot, err) in
            if err != nil {
                print(err?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true {
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        //print(documentID)
                        
                        let price = document.get("price")
                        let qty = document.get("qty")
                       
                        let foodName = document.get("name") as? String
                        // var foodName = document.get("name")
                       // print(priceFinal)
                        if let priceFinal = document.get("finalPrice")  {
                            self.cartitemshome.append(FoodCart(id: documentID as! String, foodName: foodName as! String, qty: qty as! Int, price: price as! Int, finalPrice: priceFinal as! Int))
                        }
                    }
                    self.cartTable.reloadData()
                    // self.cartTable.reloadData()
                }
            }
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == foodTable{
            return foods.count
        }
        if tableView == cartTable {
            return cartitemshome.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == foodTable {
            let cell = foodTable.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell
            //print(cartitemshome[0])
            cell.set(foods: foods[indexPath.row])
            return cell
        }
        
        if tableView == cartTable {
            
          
            
            let cell = cartTable.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
            
           // var priceFinal = self.cartitemshome[indexPath.row].price
            var initalPrice = self.cartitemshome[indexPath.row].price
            
            cell.set(cartItems: cartitemshome[indexPath.row])
            cell.priceFinal = cartitemshome[indexPath.row].price
            
            if (cartTable != nil ) {
                
                cell.actionBlockPlus = {
                    cell.qty += 1
                    var price = initalPrice * cell.qty
                    self.cartitemshome[indexPath.row].finalPrice = price
                    //cell.priceLabel.text =  String(self.cartitemshome[indexPath.row].finalPrice)
//                    self.cartTable.reloadData()
                }
                cell.actionBlockMinus = {
                    if cell.qty > 0 {
                        cell.qty -= 1
                        var price = initalPrice * cell.qty
                        cell.priceFinal = cell.priceFinal * cell.qty
                        
                        self.cartitemshome[indexPath.row].finalPrice = price

                    }
                    if cell.qty == 0 {
                        
                        self.deleteCart()
                        //self.cartTable.reloadData()
                    }
                }
            }
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func deleteCart(){
        
        let fireStoreDB = Firestore.firestore()
        
        fireStoreDB.collection("cartTable").document(cartitemshome[selectedRow].id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                DispatchQueue.main.async {
                    
                    self.cartitemshome.remove(at: self.selectedCartItem)
                    let indexPath = IndexPath(item:  self.selectedCartItem, section:  0)
                    
                    self.cartTable.deleteRows(at: [indexPath], with: .fade)
                }
               
               

//                your_array.remove(at: sender.tag) //Remove your element from array
//                        tableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0))], with: .automatic)
                
                print("Document successfully removed!")
                // print("\(self.cartitemshome[self.selectedCartItem].id)")
            }
            self.cartTable.reloadData()
        }
    }
                     
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == foodTable {
            var SelectedFood = foods[indexPath.row]
            
            myIndex = indexPath.row
            performSegue(withIdentifier: "FoodDescriptionView", sender: nil)
        }
        
        if tableView == cartTable {
            indexPathCartcell = indexPath
            selectedCartItem = indexPath.row
            print(cartitemshome[selectedCartItem].id)
            //performSegue(withIdentifier: "FoodDescriptionView", sender: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FoodDescriptionView" {
            
            let destinayionVC  = segue.destination as! FoodDescriptionViewController
            destinayionVC.selectedRow = myIndex
            destinayionVC.foodss = foods
        }
    }
}

