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
    
    class func newInstance() -> AdminHomeNextViewController {
        let ahnvc = AdminHomeNextViewController()
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped(gesture:)))
        tap.numberOfTapsRequired = 2
        adminHomeNextCollectionView.addGestureRecognizer(tap)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(gesture:)))
        lpgr.minimumPressDuration = 1.0
        adminHomeNextCollectionView.addGestureRecognizer(lpgr)
    }
    
        @objc func doubleTapped(gesture: UILongPressGestureRecognizer!) {
            let p = gesture.location(in: self.adminHomeNextCollectionView)
            if let indexPath = self.adminHomeNextCollectionView.indexPathForItem(at: p) {
                doubletapped = true
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
}

extension AdminHomeNextViewController: UICollectionViewDelegate {
    
}

extension AdminHomeNextViewController: UICollectionViewDataSource {
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
    
    
}
