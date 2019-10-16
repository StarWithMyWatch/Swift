//
//  WatchDetailViewController.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class WatchDetailViewController: UIViewController {

    
    //var event: Watch!
    
    class func newInstance(/*event: Watch*/) -> WatchDetailViewController {
        let elvc = WatchDetailViewController()
        //watch = watch
        return elvc
    }
    
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailNameLabel: UILabel!
    @IBOutlet var detailDescTextView: UITextView!
    @IBOutlet var detailPriceLabel: UILabel!
    @IBOutlet var detailOrderButton: UIButton!
    override func viewDidLoad() {
        displayData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayData(){
        /*let imageURL = URL(string: event.imageURL)
        let imageData = try! Data(contentsOf: imageURL!)
        self.imageView.image = UIImage(data: imageData)
        self.nameLabel.text = self.event.name
        self.dateLabel.text = self.event.date
        self.adressLabel.text = self.event.address
        self.descriptionField.text = self.event.description*/
        self.detailNameLabel.text = "CECI EST UN TEST DE NOM"
    }
    
    @IBAction func detailOrderButton(_ sender: Any) {
        let watch = OrderViewController.newInstance(/*user: users[indexPath.row]*/)
        self.navigationController?.pushViewController(watch, animated: true)
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
