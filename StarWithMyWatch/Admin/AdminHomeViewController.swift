//
//  AdminHomeViewController.swift
//  StarWithMyWatch
//
//  Created by Vithursan Sivakumaran on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class AdminHomeViewController: UIViewController {

    @IBOutlet weak var adminHomeCollectionView: UICollectionView!
    @IBOutlet weak var adminHomeTabBar: UITabBar!
    
    var doubletapped = false
    var longPressure = false
    
    class func newInstance() -> AdminHomeViewController {
        let ahvc = AdminHomeViewController()
        return ahvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adminHomeCollectionView.delegate = self
        self.adminHomeCollectionView.dataSource = self
        self.adminHomeCollectionView.register(UINib(nibName: "AdminHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AdminHomeViewController.adminCellId)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped(gesture:)))
        tap.numberOfTapsRequired = 2
        adminHomeCollectionView.addGestureRecognizer(tap)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(gesture:)))
        lpgr.minimumPressDuration = 1.0
        adminHomeCollectionView.addGestureRecognizer(lpgr)
        
        
        // Do any additional setup after loading the view.
    }

    @objc func doubleTapped(gesture: UILongPressGestureRecognizer!) {
        let p = gesture.location(in: self.adminHomeCollectionView)
        if let indexPath = self.adminHomeCollectionView.indexPathForItem(at: p) {
            doubletapped = true
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
}

extension AdminHomeViewController: UICollectionViewDelegate {
    
}

extension AdminHomeViewController: UICollectionViewDataSource {
    
    public static let adminCellId = "ADMIN_CELL_ID"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdminHomeViewController.adminCellId, for: indexPath) as! AdminHomeCollectionViewCell
        if(doubletapped){
            cell.imageLike.image = UIImage(named: "coeurPNG")
            doubletapped = false
        }
        if(longPressure){
            cell.imageLike.image = nil
            longPressure = false
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
