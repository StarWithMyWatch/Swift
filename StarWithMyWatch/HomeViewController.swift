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
    
    @IBOutlet var btnUser: UIButton!
    @IBOutlet var btnAdmin: UIButton!
    override func viewDidLoad() {
        btnUser.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        btnUser.layer.cornerRadius = 0.3 * btnUser.bounds.size.width
        btnUser.clipsToBounds = true
        btnAdmin.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        btnAdmin.layer.cornerRadius = 0.3 * btnAdmin.bounds.size.width
        btnAdmin.clipsToBounds = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnAdminConnect(_ sender: Any) {
        WatchService.default.getPhotosMan { (photosMen) in
            WatchService.default.getPhotosWoman(completion: { (photosWomen) in
                let next = AdminHomeViewController.newInstance(usersMan : photosMen, usersWoman : photosWomen)
                self.navigationController?.pushViewController(next, animated: true)
            })
            
        }
        
    }
    @IBAction func btnSeConnecter(_ sender: UIButton) {
        WatchService.default.getWatchs { (watchs) in
            let next = WatchListViewController.newInstance(watchs:watchs)
            self.navigationController?.pushViewController(next, animated: true)
        }
       
        
        
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
