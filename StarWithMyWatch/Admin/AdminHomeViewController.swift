//
//  AdminHomeViewController.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class AdminHomeViewController: BasicViewController{

    @IBOutlet weak var adminHomeCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var doubletapped = false
    var longPressure = false
    var choosenList : [String] = []
    var choosenListImage : [String] = []
    var usersMen : [User] = []
    var usersWomen : [User] = []
    
    class func newInstance(usersMan : [User], usersWoman : [User]) -> AdminHomeViewController {
        let ahvc = AdminHomeViewController()
        ahvc.usersMen = usersMan
        ahvc.usersWomen = usersWoman
        return ahvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Sélection Femme"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Suivant", style: .done, target: self, action: #selector(nextPageWoman))
        self.adminHomeCollectionView.delegate = self
        self.adminHomeCollectionView.dataSource = self
        self.adminHomeCollectionView.register(UINib(nibName: "AdminHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AdminHomeViewController.adminCellId)
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped(gesture:)))
        tap.numberOfTapsRequired = 2
        adminHomeCollectionView.addGestureRecognizer(tap)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(gesture:)))
        lpgr.minimumPressDuration = 0.5
        adminHomeCollectionView.addGestureRecognizer(lpgr)

        
        
        // Do any additional setup after loading the view.
    }

    @objc func doubleTapped(gesture: UITapGestureRecognizer!) {
        let p = gesture.location(in: self.adminHomeCollectionView)
        if let indexPath = self.adminHomeCollectionView.indexPathForItem(at: p) {
            doubletapped = true
            if(choosenList.count == 2) {
                Toast.show(message: "Vous avez atteint le nombre max de séléctions femmes\nPassez à la page suivante", controller: self)
            }
            adminHomeCollectionView.reloadItems(at: [indexPath])
        } else {
            print("no index path")
        }
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer!) {
        let p = gesture.location(in: self.adminHomeCollectionView)
        if let indexPath = self.adminHomeCollectionView.indexPathForItem(at: p) {
            longPressure = true
            adminHomeCollectionView.reloadItems(at: [indexPath])
        } else {
            print("no index path")
        }
    }
    
    @objc func nextPageWoman() {
        if(choosenList.count == 2){
            let next = AdminHomeNextViewController.newInstance(usersMenChoosen : self.choosenList, usersMenChoosenImage : self.choosenListImage, usersWomen : usersWomen)
            self.navigationController?.pushViewController(next, animated: true)
        } else {
            Toast.show(message: "Vous devez au moins choisir 2 photos", controller: self)
        }
        
    }
}

extension AdminHomeViewController: UICollectionViewDelegate {
    
}

extension AdminHomeViewController: UICollectionViewDataSource {
    
    public static let adminCellId = "ADMIN_CELL_ID"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersMen.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdminHomeViewController.adminCellId, for: indexPath) as! AdminHomeCollectionViewCell
        let urlImage = URL(string: usersMen[indexPath.row].image)
        let imageData = try! Data(contentsOf: urlImage!)
        cell.image.image = UIImage(data: imageData)
        if(choosenList.count < 2) {
            if(doubletapped){
                cell.imageLike.image = UIImage(named: "coeurFondRouge")
                doubletapped = false
                if(!choosenList.contains(usersMen[indexPath.row]._id)){
                    choosenList.append(usersMen[indexPath.row]._id)
                }
                if(!choosenListImage.contains(usersMen[indexPath.row].image)){
                    choosenListImage.append(usersMen[indexPath.row].image)
                }
            }
            if(longPressure){
                cell.imageLike.image = nil
                longPressure = false
                choosenList.removeAll { (e) -> Bool in
                    return e == usersMen[indexPath.row]._id
                }
                choosenListImage.removeAll { (e) -> Bool in
                    return e == usersMen[indexPath.row].image
                }
            }
            print(choosenList)
        } else if (choosenList.count == 2) {
            if(longPressure){
                cell.imageLike.image = nil
                longPressure = false
                choosenList.removeAll { (e) -> Bool in
                    return e == usersMen[indexPath.row]._id
                }
                choosenListImage.removeAll { (e) -> Bool in
                    return e == usersMen[indexPath.row].image
                }
            }
        } else {
            Toast.show(message: "Erreur", controller: self)
        }
        
        
        //setupCell(indexPath: indexPath, cell: cell)
        return cell
    }
    
    //    func setupCell(indexPath: IndexPath, cell: adminHomeCollectionViewCell) {
    //        let imageURL = URL(string: self.pokemonSearch[indexPath.row].sprite)
    //        let imageData = try! Data(contentsOf: imageURL!)
    //        cell.image.image = UIImage(data: imageData)
    //        cell.title.text = "\(self.pokemonSearch[indexPath.row].name)"
    //        cell.id.text = "#\(self.pokemonSearch[indexPath.row].id)"
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        goToDetails(indexPath: indexPath)
    //    }
    //
    //    func goToDetails(indexPath: IndexPath) {
    //        let idChoosen = self.pokemonSearch[indexPath.row].id
    //        let nameChoose = self.pokemonSearch[indexPath.row].name
    //        let imageChoosen = self.pokemonSearch[indexPath.row].sprite
    //        let typesChoosen = self.pokemonSearch[indexPath.row].types
    //        selectSound()
    //        let next = PokeDetailViewController.newInstance(pokemon: Pokemon(id: idChoosen, name: nameChoose, sprite: imageChoosen, types: typesChoosen), evolution: 0)
    //        self.navigationController?.pushViewController(next, animated: true)
    //    }
}
