//
//  ViewController.swift
//  Frood
//
//  Created by Maijid Moujaled on 7/12/14.
//  Copyright (c) 2014 Maijid Moujaled. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        APICLientSingleton.dataTask("/2/groups?&sign=true&lat=51.509980&lon=-0.133700", parameters: nil)

    }

   
}

