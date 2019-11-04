//
//  AdminHomeNextViewController.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class AdminHomeNextViewController: BasicViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var adminHomeNextCollectionView: UICollectionView!
    
    var choosenListWomen : [String] = []
    var choosenListWomenImage : [String] = []
    var usersMenChoosenImage : [String] = []
    var usersMenChoosen : [String] = []
    var usersWomen : [User] = []
    
    class func newInstance(usersMenChoosen : [String], usersMenChoosenImage : [String], usersWomen : [User]) -> AdminHomeNextViewController {
        let ahnvc = AdminHomeNextViewController()
        ahnvc.usersMenChoosen = usersMenChoosen
        ahnvc.usersWomen = usersWomen
        ahnvc.usersMenChoosenImage = usersMenChoosenImage
        return ahnvc
    }
    
    var doubletapped = false
    var longPressure = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Sélection Femme"
        
        self.adminHomeNextCollectionView.delegate = self
        self.adminHomeNextCollectionView.dataSource = self
        self.adminHomeNextCollectionView.register(UINib(nibName: "AdminHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AdminHomeViewController.adminCellId)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finaliser", style: .done, target: self, action: #selector(nextPage))
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped(gesture:)))
        tap.numberOfTapsRequired = 2
        adminHomeNextCollectionView.addGestureRecognizer(tap)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(gesture:)))
        lpgr.minimumPressDuration = 0.5
        adminHomeNextCollectionView.addGestureRecognizer(lpgr)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.adminHomeNextCollectionView.addGestureRecognizer(swipeLeft)

    }
    
        @objc func doubleTapped(gesture: UILongPressGestureRecognizer!) {
            let p = gesture.location(in: self.adminHomeNextCollectionView)
            if let indexPath = self.adminHomeNextCollectionView.indexPathForItem(at: p) {
                doubletapped = true
                if(choosenListWomen.count == 2) {
                    Toast.show(message: "Vous avez atteint le nombre max de séléctions femmes\nPassez à la page suivante", controller: self)
                }
                adminHomeNextCollectionView.reloadItems(at: [indexPath])
            } else {
                print("no index path")
            }
        }
        
        @objc func handleLongPress(gesture: UILongPressGestureRecognizer!) {
            let p = gesture.location(in: self.adminHomeNextCollectionView)
            if let indexPath = self.adminHomeNextCollectionView.indexPathForItem(at: p) {
                longPressure = true
                adminHomeNextCollectionView.reloadItems(at: [indexPath])
            } else {
                print("no index path")
            }
        }
    
    @objc func leftSwiped(gesture: UISwipeGestureRecognizer!) {
        print("left swiped")
        let p = gesture.location(in: self.adminHomeNextCollectionView)
        if let indexPath = self.adminHomeNextCollectionView.indexPathForItem(at: p) {
            longPressure = true
            goToDetails(indexPath: indexPath)
            // adminHomeCollectionView.reloadItems(at: [indexPath])
        } else {
            print("no index path")
        }
    }
    
        @objc func nextPage() {
            if(choosenListWomen.count == 2){
                let next = AdminHomeRecapBisViewController.newInstance(usersMenChoosen : usersMenChoosen, usersMenChoosenImage : usersMenChoosenImage, usersWomenChoosen : choosenListWomen, usersWomenChoosenImage : choosenListWomenImage)
                self.navigationController?.pushViewController(next, animated: true)
            } else {
                Toast.show(message: "Vous devez au moins choisir 2 photos", controller: self)
            }
        }
}

extension AdminHomeNextViewController: UICollectionViewDelegate {
    
}

extension AdminHomeNextViewController: UICollectionViewDataSource {
    public static let adminCellId = "ADMIN_CELL_ID"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersWomen.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdminHomeViewController.adminCellId, for: indexPath) as! AdminHomeCollectionViewCell
        let urlImage = URL(string: usersWomen[indexPath.row].image)
        do {
            let imageData = try Data(contentsOf: urlImage!)
            cell.image.image = UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
        }
        
        if(choosenListWomen.count < 2) {
            if(doubletapped){
                cell.imageLike.image = UIImage(named: "coeurFondRouge")
                doubletapped = false
                if(!choosenListWomen.contains(usersWomen[indexPath.row].email)){
                    choosenListWomen.append(usersWomen[indexPath.row].email)
                }
                if(!choosenListWomenImage.contains(usersWomen[indexPath.row].image)){
                    choosenListWomenImage.append(usersWomen[indexPath.row].image)
                }
            }
            if(longPressure){
                cell.imageLike.image = nil
                longPressure = false
                choosenListWomen.removeAll { (e) -> Bool in
                    return e == usersWomen[indexPath.row].email
                }
                choosenListWomenImage.removeAll { (e) -> Bool in
                    return e == usersWomen[indexPath.row].image
                }
            }
        } else if (choosenListWomen.count == 2) {
            if(longPressure){
                cell.imageLike.image = nil
                longPressure = false
                choosenListWomen.removeAll { (e) -> Bool in
                    return e == usersWomen[indexPath.row].email
                }
                choosenListWomenImage.removeAll { (e) -> Bool in
                    return e == usersWomen[indexPath.row].image
                }
            }
        } else {
            Toast.show(message: "Erreur", controller: self)
        }
        
        //setupCell(indexPath: indexPath, cell: cell)
        return cell
    }
    
    func goToDetails(indexPath: IndexPath) {
        let imageChoosen = self.usersWomen[indexPath.row].image
        let emailChoosen = self.usersWomen[indexPath.row].email
        let next = AdminBigScreenViewController.newInstance(image: imageChoosen, email: emailChoosen)
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
}
