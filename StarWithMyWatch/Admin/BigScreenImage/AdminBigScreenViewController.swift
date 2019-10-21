//
//  AdminBigScreenViewController.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 18/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class AdminBigScreenViewController: UIViewController {

    var image : String!
    var email : String!
    
    @IBOutlet weak var bigScreenImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    class func newInstance(image: String, email: String ) -> AdminBigScreenViewController {
        let ahvc = AdminBigScreenViewController()
        ahvc.image = image
        ahvc.email = email
        return ahvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlImage = URL(string: image)
        do {
            let imageData = try Data(contentsOf: urlImage!)
            bigScreenImageView.image = UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
        }
        
        emailLabel.text = email
        // Do any additional setup after loading the view.
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
