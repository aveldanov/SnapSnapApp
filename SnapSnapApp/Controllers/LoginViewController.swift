//
//  LoginViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/11/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class LoginViewController: UIViewController {
  var signUpMode = false
  
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var topButtonOutlet: UIButton!
  @IBOutlet weak var bottomButtonOutlet: UIButton!
  
  

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  
  @IBAction func topButtonTapped(_ sender: UIButton) {
    if let email = emailTextField.text{
      if let password = passwordTextField.text{
        
        if signUpMode{
          // Sign Up
          
          Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error{
              self.presentAlert(alert: error.localizedDescription)
            }else{
              print("Sign up was successful")

              if let user = user{
                // Add a new document with a generated ID
                var ref: DatabaseReference!

                ref = Database.database().reference()
                
                ref.child("users")
                
                  //DB!
                  
                  
                
                ){ err in
                  if let err = err {
                    print("Error adding document: \(err)")
                  } else {
//                    print("Document added with ID: \(ref!.documentID)")
                  }
                }
                
              }
              
         
              
              
              
              self.performSegue(withIdentifier: "moveToSnaps", sender: self)
            }
          }
          
        }else{
          // Login
          Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error{
              //              print(error.localizedDescription)
              self.presentAlert(alert: error.localizedDescription)
            }else{
              //              print("Login was successful")
              //              print(user?.user.uid)
              //              print(user?.credential)
              
              
              
              
              
              
              
              
              
              
              
              self.performSegue(withIdentifier: "moveToSnaps", sender: self)
              
            }
          }
          
        }
        
      }
      
    }
    
    
    
    
    
    
    
    
  }
  
  
  
  @IBAction func bottomButtonTapped(_ sender: UIButton) {
    
    if signUpMode{
      // switch to Log In
      signUpMode = false
      topButtonOutlet.setTitle("Login", for: .normal)
      bottomButtonOutlet.setTitle("Switch to Sign Up", for: .normal)
    }else{
      // switch to Sign Up
      signUpMode = true
      topButtonOutlet.setTitle("Sign Up", for: .normal)
      bottomButtonOutlet.setTitle("Switch to Login", for: .normal)
      
      
    }
    
    
    
  }
  
  
}


extension LoginViewController{
  
  
  func presentAlert(alert:String){
    
    let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
      alertVC.dismiss(animated: true, completion: nil)
    }
    alertVC.addAction(okAction)
    present(alertVC, animated: true, completion: nil)
  }
}
