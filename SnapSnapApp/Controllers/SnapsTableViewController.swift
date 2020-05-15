//
//  SnapsTableViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/11/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsTableViewController: UITableViewController {
  var snaps: [DataSnapshot] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
  var ref: DatabaseReference!
  ref = Database.database().reference()
    if let currentUserUid = Auth.auth().currentUser?.uid{
      ref.child("users").child(currentUserUid).child("snaps").observe(.childAdded) { (snapshot) in
        self.snaps.append(snapshot)
        self.tableView.reloadData()
      }

      
      
    }
    
    
  }
  
  // MARK: - Table view data source
  

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return snaps.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    let snap = snaps[indexPath.row]
    
    if let snapDict = snap.value as? NSDictionary{
      if let fromEmail = snapDict["from"] as? String{
        
        cell.textLabel?.text = fromEmail
        
      }
      
    }
    
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let snap = snaps[indexPath.row]
    
    performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "viewSnapSegue"{
      if let viewSnapVC = segue.destination as? ViewSnapViewController{
        if let snap = sender as? DataSnapshot{
          viewSnapVC.snap = snap
        }
      }
    }
  }
  
  
  
  
  
  
  
  
  @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
    do{
      try Auth.auth().signOut()
      print("Logged Out Successfully")
    }catch{
      
      
    }
    // dismiss the view controller
    dismiss(animated: true, completion: nil)
    
  }
  
  
  
  
  
  
  
  
  
}

