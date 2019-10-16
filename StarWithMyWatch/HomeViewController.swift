//
//  HomeViewController.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 15/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func connectButton(_ sender: Any) {
        let push = WatchListViewController.newInstance()
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
