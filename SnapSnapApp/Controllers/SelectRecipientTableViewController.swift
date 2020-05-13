//
//  SelectRecipientTableViewController.swift
//  SnapSnapApp
//
//  Created by Veldanov, Anton on 5/12/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit

class SelectRecipientTableViewController: UITableViewController {

  var downloadURL = ""
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        print("downloadURL!!!!!!", downloadURL)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

  

}
