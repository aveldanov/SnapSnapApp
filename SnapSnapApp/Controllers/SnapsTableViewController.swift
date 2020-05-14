//
//  SnapsTableViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/11/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsTableViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return 0
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

