//
//  LoginViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/11/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  var signUpMode = false
  
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var topButtonOutlet: UIButton!
  @IBOutlet weak var bottomButtonOutlet: UIButton!
  
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
  
  @IBAction func topButtonTapped(_ sender: UIButton) {
  }
  
  
  
  @IBAction func bottomButtonTapped(_ sender: UIButton) {
    
    if signUpMode{
      // switch to Log In
      
    }else{
      // switch to Sign Up
      
      
      
    }
    
    
    
  }
  

}

