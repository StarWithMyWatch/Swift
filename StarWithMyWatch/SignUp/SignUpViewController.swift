//
//  SignUpViewController.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 17/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class SignUpViewController: BasicViewController{

    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mdptextField: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    var gender = ""
    class func newInstance() -> SignUpViewController {
        let ahrvc = SignUpViewController()
        return ahrvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnInscrire(_ sender: UIButton) {
        if(genderSwitch.isOn){
            gender = "femme"
        } else {
            gender = "homme"
        }
        WatchService.default.addUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!, mdp: mdptextField.text!, gender: gender)
        let next = HomeViewController.newInstance()
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
