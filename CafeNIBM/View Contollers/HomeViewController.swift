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
    
    var cartitemshome = [FoodCart]()

    var myIndex = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
        //cartitemshome.append(FoodCart(id: 1, foodName: "ede", qty: 2, prize: 23))
        self.cartTable.reloadData()
        // Do any additional setup after loading the view.
        //print(foods)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.cartTable.reloadData()
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
                    self.cartTable.reloadData()
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
           
            cell.set(cartItems: cartitemshome[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == foodTable {
            var SelectedFood = foods[indexPath.row]
            
            myIndex = indexPath.row
            performSegue(withIdentifier: "FoodDescriptionView", sender: nil)
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

