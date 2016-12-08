//
//  ViewController.swift
//  Signup
//
//  Created by Nelson on 12/6/16.
//  Copyright © 2016 Nelson. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    @IBOutlet weak var usernamelable: UILabel!

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordfield: UITextField!
    @IBOutlet weak var Logoutbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        if let user = FIRAuth.auth()?.currentUser{
            self.Logoutbutton.alpha=1.0
            self.usernamelable.text = user.email
        }else{
            self.Logoutbutton.alpha=0.0
            self.usernamelable.text = ""
        }
        
    }

    @IBAction func createaccountaction(_ sender: AnyObject) {
        guard let email = emailField.text else{
            print("Not valid")
            return
        }
        
        
        if self.emailField.text == "" || self.passwordfield.text == ""{
            let alertcontroller = UIAlertController(title: "Error", message: "Please type in Email and Password.", preferredStyle: .alert)
            
            let alertdefault = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertcontroller.addAction(alertdefault)
            
            self.present(alertcontroller, animated: true, completion: nil)
        }else{
            FIRAuth.auth()?.createUser(withEmail: self.emailField.text!, password: self.passwordfield.text!, completion: {(user,error) in
                guard let uid = user?.uid else {
                    return
                }
                
                if error == nil{
                    self.Logoutbutton.alpha = 1.0
                    self.usernamelable.text = user!.email
                    self.emailField.text = ""
                    self.passwordfield.text = ""
                    let ref = FIRDatabase.database().reference(fromURL: "https://foodbuddy-8e869.firebaseio.com/")
                    let userref = ref.child("users").child(uid)
                    let values = ["Email":email]
                    userref.updateChildValues(values, withCompletionBlock: {(error,ref) in
                        
                        if error != nil{
                            print(error)
                            return
                        }else{
                            print("Saved into DB")
                        }
                        
                    })

                    
                }else{
                    let alertcontroller = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let alertdefault = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    
                    alertcontroller.addAction(alertdefault)
                    
                    self.present(alertcontroller, animated: true, completion: nil)
                }
                
            })
            
            
            
        }
    
    }
    @IBAction func Loginaction(_ sender: AnyObject) {
        
               
        if self.emailField.text == "" || self.passwordfield.text == ""{
            let alertcontroller = UIAlertController(title: "Error", message: "Please type in Email and Password.", preferredStyle: .alert)
            
            let alertdefault = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertcontroller.addAction(alertdefault)
            
            self.present(alertcontroller, animated: true, completion: nil)
        }else{
            
            FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordfield.text!, completion: {(user,error) in
                
                if error == nil{
                     let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "welcomeViewController") as! welcomeViewController
                    self.present(secondViewController, animated: true, completion: nil)
                    self.Logoutbutton.alpha = 1.0
                    self.usernamelable.text = user!.email
                    self.emailField.text = ""
                    self.passwordfield.text = ""
                    
                }else{
                    let alertcontroller = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let alertdefault = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    
                    alertcontroller.addAction(alertdefault)
                    
                    self.present(alertcontroller, animated: true, completion: nil)
                }
                
            })
            
            
            
        }
        
        
        
        
        
    }
    
    @IBAction func logoutaction(_ sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        
        self.Logoutbutton.alpha = 0.0
        self.usernamelable.text = ""
        self.emailField.text = ""
        self.passwordfield.text = ""
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "maintowelcome") {
            let svc = segue.destination as! welcomeViewController;
            
            self.emailField.text = svc.Emailstring.text 
            
        }
        
    }

    
}
