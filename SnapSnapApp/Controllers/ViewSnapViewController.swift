//
//  ViewSnapViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/14/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage


class ViewSnapViewController: UIViewController {
  
  var snap: DataSnapshot?
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var messageLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
      if let snapDict = snap?.value as? NSDictionary{
        if let description = snapDict["description"] as? String{
          if let imageURL = snapDict["imageURL"] as? String{
            
            messageLabel.text = description
            if let url = URL(string: imageURL){
              imageView.sd_setImage(with: url)
            }
          }
          
        }
        
      }
      
    
    
    
  }
  
  
  
}
