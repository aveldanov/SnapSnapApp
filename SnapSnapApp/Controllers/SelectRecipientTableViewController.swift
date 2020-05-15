//
//  SelectRecipientTableViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/12/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SelectRecipientTableViewController: UITableViewController {
  
  var downloadURL = ""
  var users: [User] = []
  var snapDescription = ""
  var imageName = ""

  
  override func viewDidLoad() {
    super.viewDidLoad()
    var ref: DatabaseReference!

    ref = Database.database().reference()
   
    ref.child("users").observe(.childAdded) { (snapshot) in
      var user = User()
      if let userDict = snapshot.value as? NSDictionary{
        if let email = userDict["email"] as? String{
          user.email = email
          user.uid = snapshot.key
          self.users.append(user)
          self.tableView.reloadData()
        }
      }
    }
    
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    let user = users[indexPath.row]
    cell.textLabel?.text = user.email
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = users[indexPath.row]

    let fromEmail = Auth.auth().currentUser?.email
    
    
    let snap = ["from":fromEmail, "description":snapDescription, "imageURL":downloadURL,"imageName":imageName]
    //DB
    var ref: DatabaseReference!
    ref = Database.database().reference()
    ref.child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
    
    navigationController?.popToRootViewController(animated: true)
  }
  

    
    
  }
  
  
  
  

