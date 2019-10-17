//
//  WatchDetailViewController.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class WatchDetailViewController: BasicViewController {

    
    var watch: Watch!
    
    class func newInstance(watch: Watch) -> WatchDetailViewController {
        let elvc = WatchDetailViewController()
        elvc.watch = watch
        return elvc
    }
    
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailNameLabel: UILabel!
    @IBOutlet var detailDescTextView: UITextView!
    @IBOutlet var detailPriceLabel: UILabel!
    @IBOutlet var detailOrderButton: UIButton!
    override func viewDidLoad() {
        detailOrderButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        detailOrderButton.layer.cornerRadius = 0.3 * detailOrderButton.bounds.size.width
        detailOrderButton.clipsToBounds = true
        detailImageView.layer.cornerRadius = detailImageView.frame.size.width / 2
        detailImageView.clipsToBounds = true
        detailImageView.layer.shadowColor = UIColor.black.cgColor
        detailImageView.layer.shadowOpacity = 0.5
        detailImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        detailImageView.layer.shadowRadius = 1
        detailImageView.layer.masksToBounds = false
        displayData()

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayData(){
        let imageURL = URL(string: watch.image)
        let imageData = try! Data(contentsOf: imageURL!)
        self.detailImageView.image = UIImage(data: imageData)
        self.detailNameLabel.text = self.watch.nom
        self.detailDescTextView.text = self.watch.desc
        self.detailPriceLabel.text = "\(self.watch.prix)€"
    }
    
    @IBAction func detailOrderButton(_ sender: Any) {
        let watch = OrderViewController.newInstance(watch: self.watch)
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
