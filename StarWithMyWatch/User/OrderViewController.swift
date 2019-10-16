//
//  OrderViewController.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    
    
    
    @IBOutlet var orderImageView: UIImageView!
    @IBOutlet var orderNameLabel: UILabel!
    @IBOutlet var orderPriceLabel: UILabel!
    @IBOutlet var orderCodeTextField: UITextField!
    @IBOutlet var orderPayButton: UIButton!
    @IBOutlet var orderPointsSwitch: UISwitch!
    var watch: Watch!
    
    class func newInstance(watch: Watch) -> OrderViewController {
        let elvc = OrderViewController()
        elvc.watch = watch
        return elvc
    }

    
    override func viewDidLoad() {
        displayData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayData(){
        let imageURL = URL(string: watch.image)
        let imageData = try! Data(contentsOf: imageURL!)
        self.orderImageView.image = UIImage(data: imageData)
        self.orderNameLabel.text = self.watch.nom
        self.orderPriceLabel.text = "\(self.watch.prix)"
        print(self.watch._id)
    }

    @IBAction func orderPointsSwitch(_ sender: Any) {
    }
    
    @IBAction func orderPayButton(_ sender: Any) {
         self.alertStatus()

       /* if orderPointsSwitch.isOn {
            print("yoyoyo")
            let params: [String:Any] = [
                "code": self.orderCodeTextField.text,
                "id": self.watch._id
            ]
            WatchService.default.paycash(params: params) { (error, status) in
             if(status == 200){
         
             }else{
                Toast.show(message: "il y a une erreur", controller: self)
                }
            }
        }else{
            print("yayayaya")
        }*/
    }
    
    func alertStatus() {
        let alert = UIAlertController(title: "Insertion réussi", message: "Votre évènement a bien été enregistré", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
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
