//
//  ListeMontreViewController.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class WatchListViewController: BasicViewController {
    public static let watchCellId = "WATCH_CELL_ID"
    var watchs: [Watch]!
    var user: UserConnect!

    @IBOutlet var watchTableView: UITableView!
    
    class func newInstance(watchs: [Watch], user: UserConnect) -> WatchListViewController{
        let elvc = WatchListViewController()
        elvc.user = user
        elvc.watchs = watchs
        return elvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.watchTableView.delegate = self
        self.watchTableView.dataSource = self
        self.watchTableView.register(UINib(nibName: "WatchListTableViewCell", bundle: nil), forCellReuseIdentifier: WatchListViewController.watchCellId)
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchUpload))

    }
    
    @objc func touchUpload() {
        let insert = AdminHomeRecapViewController.newInstance(user: self.user)
        self.navigationController?.pushViewController(insert, animated: true)
    }



}

extension WatchListViewController: UITableViewDelegate {
    
}

extension WatchListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.watchs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WatchListViewController.watchCellId, for: indexPath) as! WatchListTableViewCell
        
        let watch = watchs[indexPath.row]
        let imageURL = URL(string: watch.image)
        let imageData = try! Data(contentsOf: imageURL!)
        cell.watchImageView.image = UIImage(data: imageData)
        
        cell.watchPriceLabel.text = "\(watch.prix)€"
    
        cell.watchNameLabel.text = watch.nom
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let watch = WatchDetailViewController.newInstance(watch: watchs[indexPath.row], user: self.user)
        self.navigationController?.pushViewController(watch, animated: true)
    }
    
    
}
