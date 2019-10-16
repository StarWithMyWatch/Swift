//
//  HomeViewController.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 15/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var identifiantTextField: UITextField!
    @IBOutlet weak var mdpTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSeConnecter(_ sender: UIButton) {
        let next = AdminHomeViewController.newInstance()
        self.navigationController?.pushViewController(next, animated: true)
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
