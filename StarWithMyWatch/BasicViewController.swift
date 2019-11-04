//
//  BasicViewController.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 17/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

open class BasicViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationItem.title = "Augarde"

    }
}
