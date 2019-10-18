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
    
    class func newInstance() -> HomeViewController {
        let ahvc = HomeViewController()
        return ahvc
    }
    
    @IBOutlet var btnUser: UIButton!
    @IBOutlet var btnAdmin: UIButton!
    override func viewDidLoad() {
        btnUser.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        btnUser.layer.cornerRadius = 0.3 * btnUser.bounds.size.width
        btnUser.clipsToBounds = true
        btnAdmin.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        btnAdmin.layer.cornerRadius = 0.3 * btnAdmin.bounds.size.width
        btnAdmin.clipsToBounds = true
        self.navigationItem.setHidesBackButton(true, animated:true);
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnAdminConnect(_ sender: Any) {
        let next = SignUpViewController.newInstance()
        self.navigationController?.pushViewController(next, animated: true)
        
    }
 
    @IBAction func btnSeConnecter(_ sender: UIButton) {
        
        WatchService.default.getUser(email: self.identifiantTextField.text!, password: self.mdpTextField.text!, completion: { (user, status) in
            if(status == 401) {
                Toast.show(message: "User non reconnu", controller: self)
            } else {
                if user.type == "user" {
                    WatchService.default.getWatchs(completion: { (watchs) in
                        let next = WatchListViewController.newInstance(watchs:watchs, user: user)
                        self.navigationController?.pushViewController(next, animated: true)
                    })
                } else {
                    WatchService.default.getPhotosMan(completion: { (photosMen) in
                        WatchService.default.getPhotosWoman(completion: { (photosWomen) in
                            let next = AdminHomeViewController.newInstance(usersMan : photosMen, usersWoman : photosWomen)
                            self.navigationController?.pushViewController(next, animated: true)
                        })
                    })
                }
            }
            
        })
            
        
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
