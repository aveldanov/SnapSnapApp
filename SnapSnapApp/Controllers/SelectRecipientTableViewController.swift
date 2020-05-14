//
//  SelectRecipientTableViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/12/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SelectRecipientTableViewController: UITableViewController {
  
  var downloadURL = ""
  let db = Firestore.firestore()
  var users: [User] = []
  var snapDescription = ""

  
  override func viewDidLoad() {
    super.viewDidLoad()
    var user = User()

    
    
    
    
    db.collection("users").getDocuments(completion: { (documentSnapshot, error) in
      
         guard let document = documentSnapshot else {
           print("Error fetching document: \(error!)")
           return
         }
      
//       print("COUNT:",document.documents.count)
      for item in document.documents{
//                print("ITEM!!!! ",item.data())
                user.email = item.data()["email"] as! String
                user.uid = item.documentID
                self.users.append(user)
                for i in self.users{
                  print("USER: ! ", i.email)
                }
//                print("end of cycle")
                  self.tableView.reloadData()
  
              }
      
      
      
      
    })
      
      
//      .addSnapshotListener { documentSnapshot, error in
//        guard let document = documentSnapshot else {
//          print("Error fetching document: \(error!)")
//          return
//        }
//
//
//
//
//        //      guard let data = document.data() else {
//        //        print("Document data was empty.")
//        //        return
//        //      }
//
//        print("COUNT:",document.documents.count)
//
//        for item in document.documents{
//          print("ITEM!!!! ",item.data())
//          user.email = item.data()["email"] as! String
//          user.uid = item.documentID
//          self.users.append(user)
//          for i in self.users{
//            print("USER: ! ", i.email)
//          }
//          print("end of cycle")
//            self.tableView.reloadData()
//
//
//
//
//
//        }
//
//    }
    
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return users.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
      
      let user = self.users[indexPath.row]
      
      cell.textLabel?.text = user.email
        
    

    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = users[indexPath.row]
    if let fromEmail = Auth.auth().currentUser?.email{
      let snap = ["snaps":FieldValue.arrayUnion([["from":fromEmail, "description":snapDescription, "imageURL": downloadURL]])] as? Any
//
//      db.collection("users").document(user.uid).updateData(["snaps":FieldValue.arrayUnion(["TEST"])])
      
      db.collection("users").document(user.uid).updateData(snap as! [AnyHashable : Any])
     
      navigationController?.popToRootViewController(animated: true)
      
    }
    
    
  }
  
  
  
  
}
