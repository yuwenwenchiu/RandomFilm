//
//  WhiteNavigationController.swift
//  RandomFilm
//
//  Created by Yuwen Chiu on 2019/8/28.
//  Copyright © 2019 YuwenChiu. All rights reserved.
//

import UIKit

class WhiteNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
}
