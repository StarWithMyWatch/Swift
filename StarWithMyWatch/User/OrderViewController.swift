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
    @IBOutlet var pointsLabel: UILabel!
    var watch: Watch!
    var user: UserConnect!
    
    class func newInstance(watch: Watch, user: UserConnect) -> OrderViewController {
        let elvc = OrderViewController()
        elvc.user = user
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
        print(user as UserConnect)
        pointsLabel.text = "Points: \(user.point)"
        displayData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(logout))
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayData(){
        let imageURL = URL(string: watch.image)
        do {
            let imageData = try Data(contentsOf: imageURL!)
            self.orderImageView.image = UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
        }
        
        self.orderNameLabel.text = self.watch.nom
        self.orderPriceLabel.text = "Prix: \(self.watch.prix)€"
        
    }

    @IBAction func orderPointsSwitch(_ sender: Any) {
        
       if orderPointsSwitch.isOn {
        textFieldDeactive()
       }else{
        textFieldActive()

        }
    }
    
    @IBAction func orderPayButton(_ sender: Any) {
        

        if orderPointsSwitch.isOn {
            if (user.point > 100) {
                print("yayayaya")
                let params: [String:Any] = [
                    "email": user.email
                ]
                WatchService.default.paypoints(header: user.token,params: params) { (error, status) in
                    print("status",status)
                    print("error",error)
                    
                    self.alertStatus(points: true)
                    
                }
            }else{
                Toast.show(message: "Vous n'avez pas assez de points", controller: self)
            }
            
           
        }else{
            print(self.orderCodeTextField.text!)
            let params: [String:Any] = [
                "code": self.orderCodeTextField.text!,
                "email": user.email
            ]
            WatchService.default.paycash(header: user.token,params: params) { (error, status) in

                    self.alertStatus(points: false)
                
            }
        }
    }
    
    func textFieldActive(){
    //Turn things ON
        orderCodeTextField.isEnabled = true
    
    }
    
    func textFieldDeactive(){ //Add anything else
    //Turn things OFF
        orderCodeTextField.isEnabled = false
    }
    
    func alertStatus(points:Bool) {
        if points {
            let alert = UIAlertController(title: "BRAVO", message: "Votre achat a bien été effectué avec vos points", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Merci", style: .default, handler: { (action) -> Void in
                WatchService.default.getWatchs { (watchs) in
                    let next = WatchListViewController.newInstance(watchs:watchs, user: self.user)
                    self.navigationController?.pushViewController(next, animated: true)
                }
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
        }else{
            let alert = UIAlertController(title: "BRAVO", message: "Votre achat a bien été effectué avec votre cash", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Merci", style: .default, handler: { (action) -> Void in
                WatchService.default.getWatchs { (watchs) in
                    let next = WatchListViewController.newInstance(watchs:watchs,user: self.user)
                    self.navigationController?.pushViewController(next, animated: true)
                }
            })
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
    }
    
    @objc func logout() {
        let insert = HomeViewController.newInstance()
        self.navigationController?.pushViewController(insert, animated: true)
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
