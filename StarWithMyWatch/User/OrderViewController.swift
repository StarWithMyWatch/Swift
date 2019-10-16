//
//  OrderViewController.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    
    //var event: Watch!
    
    @IBOutlet var orderNameLabel: UILabel!
    @IBOutlet var orderPriceLabel: UILabel!
    @IBOutlet var orderCodeTextField: UITextField!
    @IBOutlet var orderPayButton: UIButton!
    @IBOutlet var orderPointsSwitch: UISwitch!
    class func newInstance(/*event: Watch*/) -> OrderViewController {
        let elvc = OrderViewController()
        //watch = watch
        return elvc
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func orderPointsSwitch(_ sender: Any) {
    }
    
    @IBAction func orderPayButton(_ sender: Any) {
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
