//
//  ViewSnapViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/14/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SDWebImage
import FirebaseStorage


class ViewSnapViewController: UIViewController {
  
  var snap: DataSnapshot?
  var imageName = ""
  
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
          if let imageName = snapDict["imageName"] as? String{
            
            self.imageName = imageName
          }
          
        }
        
      }
      
    }

  }
  //MARK: - delete snap image after it was viewed
  override func viewWillDisappear(_ animated: Bool) {
    var ref: DatabaseReference!
    
    ref = Database.database().reference()
    
    
    if let currentUserUid = Auth.auth().currentUser?.uid{
      if let key = snap?.key{
        ref.child("users").child(currentUserUid).child("snaps").child(key).removeValue()
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        print("[ViewSnapVC] imageName", imageName)
        storageRef.child("images").child(imageName).delete(completion: nil)
        
        
      }
    }
    
    
    
    
  }
  
  
  
}
