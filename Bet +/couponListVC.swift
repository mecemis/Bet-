//
//  FirstViewController.swift
//  Bet +
//
//  Created by Murat on 13.12.2018.
//  Copyright © 2018 Murat. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class couponListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
  
    
    //MARK: Variables
    var couponTypeArray = [String]()
    var couponSystemArray = [String]()
    var couponTotalOddsArray = [String]()
    var couponStatusArray = [String]()
    var uuidArray = [String]()
    var couponId:String = "";
    
    var refreshControl = UIRefreshControl()
    
    
    var isRegistering = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        refresh()
        
        tableView.backgroundColor = .clear
        
        getDataFromFirebase()
        
        /*refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refreshPull:", for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
       */
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshPull), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.uid == "FkTIZXsRk1VdhpF9AFLLVUMvZrE3" {
            addButton.isEnabled = true
            addButton.tintColor = .black
        }else{
            addButton.isEnabled = false
            addButton.tintColor = .clear
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponTotalOddsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! couponListCell
        
       // cell.backgroundColor = UIColor(red: 84.0 / 255.0, green: 187.0 / 255.0, blue: 187.0 / 255.0, alpha: 1.0)
        
         cell.layer.backgroundColor = UIColor.clear.cgColor
        
        cell.systemLabel.text = couponSystemArray[indexPath.row]
        cell.couponTypeLabel.text = couponTypeArray[indexPath.row]
        cell.totalOddsLabel.text = couponTotalOddsArray[indexPath.row]
        
        if cell.couponTypeLabel.text == "Football" || cell.couponTypeLabel.text == "Futbol" || cell.couponTypeLabel.text == "football" || cell.couponTypeLabel.text == "futbol"{
            cell.couponTypeImage.image = UIImage(named: "soccer.png")
        }else if cell.couponTypeLabel.text == "Basketball" || cell.couponTypeLabel.text == "Basketbol" || cell.couponTypeLabel.text == "basketball" || cell.couponTypeLabel.text == "basketbol"{
            cell.couponTypeImage.image = UIImage(named: "basketball.png")
        }
        
        
        
        if couponStatusArray.contains("false"){
            cell.statusImage.image = UIImage(named: "unchecked_coupon.png")
        }else if couponStatusArray.contains("stable"){
            cell.statusImage.image = UIImage(named: "stable_coupon.png")
        }else {
            cell.statusImage.image = UIImage(named: "checked_coupon.png")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "couponDetailsVC") as! couponDetailsVC
        self.present(vc, animated:true, completion:nil)
        let vc1 = couponDetailsVC()
        //vc1.show(<#T##vc: UIViewController##UIViewController#>, sender: Any?)
        //performSegue(withIdentifier: "toDetailsVC", sender: nil)
 */
        let myVC = storyboard?.instantiateViewController(withIdentifier: "couponDetailsVC") as! couponDetailsVC
        myVC.selectedCoupon = indexPath.row
        navigationController?.pushViewController(myVC, animated: true)
    }
    @IBAction func addClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toUploadVC", sender: nil)
        
    }
    
    class Colors {
        var gl:CAGradientLayer!
        
        init() {
            let colorTop = UIColor(red: 15.0 / 255.0, green: 118.0 / 255.0, blue: 128.0 / 255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 84.0 / 255.0, green: 187.0 / 255.0, blue: 187.0 / 255.0, alpha: 1.0).cgColor
            
            self.gl = CAGradientLayer()
            self.gl.colors = [colorTop, colorBottom]
            self.gl.locations = [0.0, 1.0]
        }
    }
    
    let colors = Colors()
    
    func refresh() {
        view.backgroundColor = UIColor.clear
        var backgroundLayer = colors.gl
        backgroundLayer!.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func getDataFromFirebase() {
        
        let databaseReference = Database.database().reference()
        
        databaseReference.child("users").observe(DataEventType.childAdded) { (snapshot) in
          
            
            let values = snapshot.value! as! NSDictionary
            
            let post = values["post"] as! NSDictionary
            
            let postID = post.allKeys
            
            for id in postID {
                let singlePost = post[id] as! NSDictionary
                
                if singlePost["matchTypes"] as? String != nil{
                    self.couponTypeArray.append(singlePost["matchTypes"] as! String)
                }
                
                if singlePost["couponSystem"] as? String != nil{
                    self.couponSystemArray.append(singlePost["couponSystem"] as! String)
                }
                
                if  singlePost["couponTotalOdds"] as? String != nil{
                    self.couponTotalOddsArray.append(singlePost["couponTotalOdds"] as! String)
                }
                
                if singlePost["isFirstMatchChecked"] as! String != ""{
                    self.couponStatusArray.append(singlePost["isFirstMatchChecked"] as! String)
                }
                
                if singlePost["isSecondMatchChecked"] as! String != ""{
                    self.couponStatusArray.append(singlePost["isSecondMatchChecked"] as! String)
                }
                
                if singlePost["isThirdMatchChecked"] as! String != ""{
                    self.couponStatusArray.append(singlePost["isThirdMatchChecked"] as! String)
                }
                
                if singlePost["isFourthMatchChecked"] as! String != ""{
                    self.couponStatusArray.append(singlePost["isFourthMatchChecked"] as! String)
                }
                
                if singlePost["uuid"] as! String != ""{
                    self.uuidArray.append(singlePost["uuid"] as! String)
                }
 
                //self.couponTypeArray.append(singlePost["matchTypes"] as! String)
               // self.couponSystemArray.append(singlePost["couponSystem"] as! String)
               //self.couponTotalOddsArray.append(singlePost["couponTotalOdds"] as! String)
 
                
                
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func refreshPull(sender:AnyObject) {
        // Code to refresh table view
        
        self.couponTypeArray.removeAll(keepingCapacity: false)
        self.couponTotalOddsArray.removeAll(keepingCapacity: false)
        self.couponSystemArray.removeAll(keepingCapacity: false)
        
        getDataFromFirebase()
        
        refreshControl.endRefreshing()
    }
    
    
    
}

