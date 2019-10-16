//
//  AdminHomeNextViewController.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class AdminHomeNextViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var adminHomeNextCollectionView: UICollectionView!
    
    var choosenListWomen : [String] = []
    var usersMenChoosen : [String] = []
    var usersWomen : [User] = []
    
    class func newInstance(usersMenChoosen : [String], usersWomen : [User]) -> AdminHomeNextViewController {
        let ahnvc = AdminHomeNextViewController()
        ahnvc.usersMenChoosen = usersMenChoosen
        ahnvc.usersWomen = usersWomen
        return ahnvc
    }
    
    var doubletapped = false
    var longPressure = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Sélection Homme"
        
        self.adminHomeNextCollectionView.delegate = self
        self.adminHomeNextCollectionView.dataSource = self
        self.adminHomeNextCollectionView.register(UINib(nibName: "AdminHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AdminHomeViewController.adminCellId)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finaliser", style: .done, target: self, action: #selector(nextPage))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped(gesture:)))
        tap.numberOfTapsRequired = 2
        adminHomeNextCollectionView.addGestureRecognizer(tap)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(gesture:)))
        lpgr.minimumPressDuration = 0.5
        adminHomeNextCollectionView.addGestureRecognizer(lpgr)
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
    
        @objc func nextPage() {
            if(choosenListWomen.count == 2){
                let next = AdminHomeRecapViewController.newInstance(usersMen: usersMenChoosen, usersWomen : choosenListWomen)
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
        let imageData = try! Data(contentsOf: urlImage!)
        cell.image.image = UIImage(data: imageData)
        if(choosenListWomen.count < 2) {
            if(doubletapped){
                cell.imageLike.image = UIImage(named: "coeurRouge")
                doubletapped = false
                if(!choosenListWomen.contains(usersWomen[indexPath.row]._id)){
                    choosenListWomen.append(usersWomen[indexPath.row]._id)
                }
            }
            if(longPressure){
                cell.imageLike.image = nil
                longPressure = false
                choosenListWomen.removeAll { (e) -> Bool in
                    return e == usersWomen[indexPath.row]._id
                }
            }
        } else if (choosenListWomen.count == 2) {
            if(longPressure){
                cell.imageLike.image = nil
                longPressure = false
                choosenListWomen.removeAll { (e) -> Bool in
                    return e == usersWomen[indexPath.row]._id
                }
            }
        } else {
            Toast.show(message: "Erreur", controller: self)
        }
        
        //setupCell(indexPath: indexPath, cell: cell)
        return cell
    }
    
    
}
