//
//  AdminHomeRecapViewController.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class AdminHomeRecapViewController: BasicViewController {

    
    @IBOutlet var selectImageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    class func newInstance() -> AdminHomeRecapViewController {
        let ahrvc = AdminHomeRecapViewController()
        return ahrvc
    }
    
    override func viewDidLoad() {
        selectImageButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        selectImageButton.layer.cornerRadius = 0.3 * selectImageButton.bounds.size.width
        selectImageButton.clipsToBounds = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(touchUpload))


        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func touchUpload() {
        //let insert = AdminHomeRecapViewController.newInstance(usersMen: ["test"], usersWomen: ["test"])
        //self.navigationController?.pushViewController(insert, animated: true)
    }
    
    
    
    @IBAction func selectImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
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

extension AdminHomeRecapViewController: UINavigationControllerDelegate {
    
}


extension AdminHomeRecapViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            
        } else {
            print("ERROR IMAGE")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
