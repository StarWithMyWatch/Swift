//
//  OrderViewController.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class OrderViewController: BasicViewController {

    
    
    
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
        orderPayButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        orderPayButton.layer.cornerRadius = 0.3 * orderPayButton.bounds.size.width
        orderPayButton.clipsToBounds = true
        orderImageView.layer.cornerRadius = orderImageView.frame.size.width / 2
        orderImageView.clipsToBounds = true
        orderImageView.layer.shadowColor = UIColor.black.cgColor
        orderImageView.layer.shadowOpacity = 0.5
        orderImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        orderImageView.layer.shadowRadius = 1
        orderImageView.layer.masksToBounds = false

        displayData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayData(){
        let imageURL = URL(string: watch.image)
        let imageData = try! Data(contentsOf: imageURL!)
        self.orderImageView.image = UIImage(data: imageData)
        self.orderNameLabel.text = self.watch.nom
        self.orderPriceLabel.text = "Prix: \(self.watch.prix)€"
        
    }

    @IBAction func orderPointsSwitch(_ sender: Any) {
    }
    
    @IBAction func orderPayButton(_ sender: Any) {
        

        if orderPointsSwitch.isOn {
            print("yayayaya")
            let params: [String:Any] = [
                "code": self.orderCodeTextField.text!,
                "id": self.watch._id
            ]
            WatchService.default.paypoints(params: params) { (error, status) in
                print(status)
                if(status == 200){
                    self.alertStatus(points: true)
                }else{
                    Toast.show(message: "il y a une erreur", controller: self)
                }
            }
           
        }else{
            print("yoyoyo")
            let params: [String:Any] = [
                "code": self.orderCodeTextField.text!,
                "id": self.watch._id
            ]
            WatchService.default.paycash(params: params) { (error, status) in
                print(status)
                if(status == 200){
                    self.alertStatus(points: false)
                }else{
                    Toast.show(message: "il y a une erreur", controller: self)
                }
            }
        }
    }
    
    func alertStatus(points:Bool) {
        if points {
            let alert = UIAlertController(title: "BRAVO", message: "Votre achat a bien été effectué avec vos points", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Merci", style: .default, handler: { (action) -> Void in
                WatchService.default.getWatchs { (watchs) in
                    let next = WatchListViewController.newInstance(watchs:watchs)
                    self.navigationController?.pushViewController(next, animated: true)
                }
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
        }else{
            let alert = UIAlertController(title: "BRAVO", message: "Votre achat a bien été effectué avec votre cash", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Merci", style: .default, handler: { (action) -> Void in
                WatchService.default.getWatchs { (watchs) in
                    let next = WatchListViewController.newInstance(watchs:watchs)
                    self.navigationController?.pushViewController(next, animated: true)
                }
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
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
