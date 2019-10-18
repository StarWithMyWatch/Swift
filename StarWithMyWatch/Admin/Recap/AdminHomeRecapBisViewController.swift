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
    
    @IBOutlet var reselectImageBtn: UIButton!
    @IBOutlet weak var validerbtn: UIButton!
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
        self.navigationItem.title = "Recapitulation"
        self.navigationItem.setHidesBackButton(true, animated:true);
        reselectImageBtn.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        reselectImageBtn.layer.cornerRadius = 0.3 * reselectImageBtn.bounds.size.width
        reselectImageBtn.clipsToBounds = true
        validerbtn.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        validerbtn.layer.cornerRadius = 0.3 * validerbtn.bounds.size.width
        validerbtn.clipsToBounds = true

        imageMenOne.image = UIImage(data: try! Data(contentsOf: URL(string: usersWomenChoosenImage[0])!))
        imageMenTwo.image = UIImage(data: try! Data(contentsOf: URL(string: usersWomenChoosenImage[1])!))
        
        imageWomenOne.image = UIImage(data: try! Data(contentsOf: URL(string: usersMenChoosenImage[0])!))
        imageWomenTwo.image = UIImage(data: try! Data(contentsOf: URL(string: usersMenChoosenImage[1])!))
        
       
    }

    @IBAction func changeButton(_ sender: Any) {
        WatchService.default.getPhotosMan { (photosMen) in
            WatchService.default.getPhotosWoman(completion: { (photosWomen) in
                let next = AdminHomeViewController.newInstance(usersMan : photosMen, usersWoman : photosWomen)
                self.navigationController?.pushViewController(next, animated: true)
            })
            
        }
    }
    
    
    @IBAction func validerButton(_ sender: UIButton) {
        WatchService.default.chooseStar(emailMen: usersMenChoosen, emailWomen: usersWomenChoosen, completion: { status in
            if(status == 200) {
                let alert = UIAlertController(title: "Désolé !", message: "Le concours est clos.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    let next = HomeViewController.newInstance()
                    self.navigationController?.pushViewController(next, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Merci !", message: "Les gagnants ont étés choisi.\nLe concours est clos.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    let next = HomeViewController.newInstance()
                    self.navigationController?.pushViewController(next, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
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
