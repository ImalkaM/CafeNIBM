//
//  SignUpViewController.swift
//  CafeNIBM
//
//  Created by Imalka Muthukumara on 2021-02-26.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var errlabel: UILabel!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func registerTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }else {
            let email = self.emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNumber = self.phoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = self.passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if  err != nil {
                    self.showError("Error creating user")
                }else {
                    
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["phonenumber":phoneNumber, "email":email, "uid": result!.user.uid]){
                        (error) in
                        
                        if error != nil {
                            self.showError("error saving user data")
                        }
                    }
                    self.transitionToHome()
                }
            }
        }
    }
    
    func transitionToHome() {
     let homeViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func validateFields() -> String? {
        
        if emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill all the fields"
            
        }
        
        return nil
    }
    
    func showError(_ message:String) {
        errlabel.text = message
        errlabel.alpha = 1
    }
    

}
