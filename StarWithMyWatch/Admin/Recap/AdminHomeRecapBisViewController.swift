//
//  AdminHomeRecapBisViewController.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 17/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class AdminHomeRecapBisViewController: UIViewController {

    @IBOutlet weak var imageMenOne: UIImageView!
    
    @IBOutlet weak var imageMenTwo: UIImageView!
    @IBOutlet weak var imageWomenOne: UIImageView!
    @IBOutlet weak var imageWomenTwo: UIImageView!
    
    var usersWomenChoosen : [String] = []
    var usersWomenChoosenImage : [String] = []
    var usersMenChoosenImage : [String] = []
    var usersMenChoosen : [String] = []
    
    class func newInstance(usersMenChoosen : [String], usersMenChoosenImage : [String], usersWomenChoosen : [String], usersWomenChoosenImage : [String]) -> AdminHomeRecapBisViewController {
        let ahnvc = AdminHomeRecapBisViewController()
        ahnvc.usersMenChoosen = usersMenChoosen
        ahnvc.usersMenChoosenImage = usersMenChoosenImage
        ahnvc.usersWomenChoosen = usersWomenChoosen
        ahnvc.usersWomenChoosenImage = usersWomenChoosenImage
        return ahnvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageMenOne.image = UIImage(data: try! Data(contentsOf: URL(string: usersWomenChoosenImage[0])!))
        imageMenTwo.image = UIImage(data: try! Data(contentsOf: URL(string: usersWomenChoosenImage[1])!))
        
        imageWomenOne.image = UIImage(data: try! Data(contentsOf: URL(string: usersMenChoosenImage[0])!))
        imageWomenTwo.image = UIImage(data: try! Data(contentsOf: URL(string: usersMenChoosenImage[1])!))
        
       
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
