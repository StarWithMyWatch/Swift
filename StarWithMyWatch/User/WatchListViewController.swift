//
//  ListeMontreViewController.swift
//  StarWithMyWatch
//
//  Created by Arthur BLANC on 16/10/2019.
//  Copyright © 2019 Vithursan Sivakumaran. All rights reserved.
//

import UIKit

class WatchListViewController: UIViewController {
    public static let watchCellId = "WATCH_CELL_ID"
    //var watch: [Watch]!

    @IBOutlet var watchTableView: UITableView!
    class func newInstance(/*watchs: [Watch]*/) -> WatchListViewController{
        let elvc = WatchListViewController()
        //elvc.watchs = watchs
        return elvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.watchTableView.delegate = self
        self.watchTableView.dataSource = self
        self.watchTableView.register(UINib(nibName: "WatchListTableViewCell", bundle: nil), forCellReuseIdentifier: WatchListViewController.watchCellId)

        

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

extension WatchListViewController: UITableViewDelegate {
    
}

extension WatchListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WatchListViewController.watchCellId, for: indexPath) as! WatchListTableViewCell
        
        /*let user = users[indexPath.row]
        let imageURL = URL(string: user.photo)
        let imageData = try! Data(contentsOf: imageURL!)
        cell.pictureView.image = UIImage(data: imageData)
        cell.usernameLabel.text = user.username*/
    
        cell.watchNameLabel.text = "testtt"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let watch = WatchDetailViewController.newInstance(/*user: users[indexPath.row]*/)
        self.navigationController?.pushViewController(watch, animated: true)
    }
    
    
}