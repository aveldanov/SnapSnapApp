//
//  SelectRecipientTableViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/12/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import FirebaseFirestore

class SelectRecipientTableViewController: UITableViewController {

  var downloadURL = ""
  let db = Firestore.firestore()
  let user = User()
  var users: [User] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()

          
            db.collection("users")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
        //      guard let data = document.data() else {
        //        print("Document data was empty.")
        //        return
        //      }
              print("Current data: \(document.documents.map{$0.data().values})")
              
              for item in document.documents{
                self.user.email = item.data()["email"] as! String
                self.user.uid = item.documentID
                self.users.append(self.user)
                print("USERS:",self.users[0].email)
                self.tableView.reloadData()
              }
              
            }    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return users.count
    }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    let user = users[indexPath.row]
    cell.textLabel?.text = user.email
    return cell
  }
  
  

  

}
