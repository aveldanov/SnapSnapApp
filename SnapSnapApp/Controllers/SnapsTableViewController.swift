//
//  SnapsTableViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/11/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SnapsTableViewController: UITableViewController {
  let db = Firestore.firestore()
  var snaps: [DocumentSnapshot] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let uid = Auth.auth().currentUser?.uid{
      
//      db.collection("users").getDocuments { (documentSnapshot, error) in
//        guard let document = documentSnapshot else {
//                         print("Error fetching document: \(error!)")
//                         return
//                       }
//
//        for item in document.documents{
//
//          print("ITEM", item.data())
//          self.snaps.append(item)
//
//        }
//
//
//
//      }
      
      
      
      db.collection("users").document(uid).addSnapshotListener(includeMetadataChanges: true) { (documentSnapshot, error) in
        
        
      }
      
      

      db.collection("users").document(uid).addSnapshotListener() { (documentSnapshot, error) in

        guard let document = documentSnapshot else {
                 print("Error fetching document: \(error!)")
                 return
               }
          self.snaps.append(document)
        print("OHSNAP",self.snaps.count)





      }
      
      
      
      
//      db.collection("users").document(uid).addSnapshotListener { (documentSnapshot, error) in
//        guard let document = documentSnapshot else {
//                print("Error fetching document: \(error!)")
//                return
//              }
//
//        self.snaps.append(document)
//
//        self.tableView.reloadData()
//        print("OHSNAP",self.snaps.count)
//      }
      

//      db.collection("users").document(uid).getDocument { (documentSnapshot, error) in
//
//
// guard let document = documentSnapshot else {
//          print("Error fetching document: \(error!)")
//          return
//        }
// document.data()?.compactMapValues({ (item) -> Any? in
//   self.snaps.append(document)
//
//   self.tableView.reloadData()
//   print("OHSNAP",self.snaps.count)
//   return self.snaps
// })
//
//
//
//      }



    }
    
    
  }
  
  // MARK: - Table view data source
  
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return snaps.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = UITableViewCell()
    let snap = snaps[indexPath.row]
//    if let snapDict = snap as? Dictionary<String, String>{
//      if let fromEmail = snapDict["from"] as? String{
//        cell.textLabel?.text = fromEmail
//
//
//      }
//    }
    self.tableView.reloadData()

    if let snapDict = snap.data() as NSDictionary?{
//      print("TLJLKJLKRJ",snap.data()?.values)
      if let fromEmail = snapDict["email"] as? String{
       print("FROM EMAIL!!!",fromEmail)
        
        cell.textLabel?.text = fromEmail
        
      }
      
    }
    
    
    return cell
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

