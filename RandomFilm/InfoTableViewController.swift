//
//  InfoTableViewController.swift
//  RandomFilm
//
//  Created by Yuwen Chiu on 2019/8/30.
//  Copyright © 2019 YuwenChiu. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {
    
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }

}
