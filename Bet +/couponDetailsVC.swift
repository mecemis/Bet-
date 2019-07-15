//
//  couponDetailsVC.swift
//  Bet +
//
//  Created by Murat on 13.12.2018.
//  Copyright © 2018 Murat. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

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
class couponDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var matchNamesArray = [String]()
    var matchDatesArray = [String]()
    var matchOddsArray = [String]()
    var matchLeagueArray = [String]()
    var matchPredictsArray = [String]()
    var matchStatusArray = [String]()
    
    //var selectedUuid = "-LUlhcIW_tYvzWHlKg5f"
    var selectedCoupon = 0
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        
        refresh()
        
        getDataFromFirebase()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshPull), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! couponDetailsCell
        //cell.backgroundColor = UIColor(red: 84.0 / 255.0, green: 187.0 / 255.0, blue: 187.0 / 255.0, alpha: 1.0)
        
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        cell.matchNameLabel.text = matchNamesArray[indexPath.row]
        cell.matchLeagueLabel.text = matchLeagueArray[indexPath.row]
        cell.matchOddLabel.text = matchOddsArray[indexPath.row]
        cell.matchDateLabel.text = matchDatesArray[indexPath.row]
        cell.matchPredictLabel.text = matchPredictsArray[indexPath.row]
        cell.matchStatusLabel.text = matchStatusArray[indexPath.row]
        
        if cell.matchStatusLabel.text == "stable" {
            cell.matchStatusImage.image = UIImage(named: "stable_match.png")
        } else if cell.matchStatusLabel.text == "true"{
            cell.matchStatusImage.image = UIImage(named: "checked_match.png")
        }else if cell.matchStatusLabel.text == "false" {
            cell.matchStatusImage.image = UIImage(named: "unchecked_match.png")
        }
        
        return cell
    }
    
    @objc func refreshPull(sender:AnyObject) {
        // Code to refresh table view
        
        self.matchNamesArray.removeAll(keepingCapacity: false)
        self.matchStatusArray.removeAll(keepingCapacity: false)
        self.matchPredictsArray.removeAll(keepingCapacity: false)
        self.matchDatesArray.removeAll(keepingCapacity: false)
        self.matchOddsArray.removeAll(keepingCapacity: false)
        self.matchLeagueArray.removeAll(keepingCapacity: false)
        
        getDataFromFirebase()
        
        refreshControl.endRefreshing()
    }
    
    /*class Colors {
        var gl:CAGradientLayer!
        
        init() {
            let colorTop = UIColor(red: 15.0 / 255.0, green: 118.0 / 255.0, blue: 128.0 / 255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 84.0 / 255.0, green: 187.0 / 255.0, blue: 187.0 / 255.0, alpha: 1.0).cgColor
            
            self.gl = CAGradientLayer()
            self.gl.colors = [colorTop, colorBottom]
            self.gl.locations = [0.0, 1.0]
        }
    }
    */
    let colors = Colors()
    
    func refresh() {
        view.backgroundColor = UIColor.clear
        var backgroundLayer = colors.gl
        backgroundLayer!.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func getDataFromFirebase() {
        
        self.matchNamesArray.removeAll(keepingCapacity: false)
        self.matchStatusArray.removeAll(keepingCapacity: false)
        self.matchPredictsArray.removeAll(keepingCapacity: false)
        self.matchDatesArray.removeAll(keepingCapacity: false)
        self.matchOddsArray.removeAll(keepingCapacity: false)
        self.matchLeagueArray.removeAll(keepingCapacity: false)
        
        let databaseReference = Database.database().reference()
        
        databaseReference.child("users").observe(DataEventType.childAdded) { (snapshot) in
            
            
            let values = snapshot.value as! NSDictionary
            
            let post = values["post"] as! NSDictionary
            
            let postID = post.allKeys
            
            //let a = post.value(forKey: self.selectedUuid)
            //var aa = postID[self.selectedCoupon]
            //let postID = post.value(forKey: self.selectedUuid as String)
            //for id in postID {
                //let singlePost = post[id] as! NSDictionary
                let singlePost = post[postID[self.selectedCoupon]] as! NSDictionary
                
                
                if singlePost["firstMatchName"] as! String != ""{
                    self.matchNamesArray.append(singlePost["firstMatchName"] as! String)
                }
                
                if singlePost["secondMatchName"] as! String != ""{
                self.matchNamesArray.append(singlePost["secondMatchName"] as! String)
                }
                
                if singlePost["thirdMatchName"] as! String != ""{
                   self.matchNamesArray.append(singlePost["thirdMatchName"] as! String)
                }
              
                if singlePost["fourthMatchName"] as! String != ""{
                    self.matchNamesArray.append(singlePost["fourthMatchName"] as! String)
                }
                
                if singlePost["firstMatchLeague"] as! String != ""{
                    self.matchLeagueArray.append(singlePost["firstMatchLeague"] as! String)
                }
                
                if singlePost["secondMatchLeague"] as! String != ""{
                    self.matchLeagueArray.append(singlePost["secondMatchLeague"] as! String)
                }
                
                if singlePost["thirdMatchLeague"] as! String != ""{
                    self.matchLeagueArray.append(singlePost["thirdMatchLeague"] as! String)
                }
                
                if singlePost["fourthMatchLeague"] as! String != ""{
                    self.matchLeagueArray.append(singlePost["fourthMatchLeague"] as! String)
                }
                
                if singlePost["firstMatchDate"] as! String != ""{
                    self.matchDatesArray.append(singlePost["firstMatchDate"] as! String)
                }
                
                if singlePost["secondMatchDate"] as! String != ""{
                    self.matchDatesArray.append(singlePost["secondMatchDate"] as! String)
                }
                
                if singlePost["thirdMatchDate"] as! String != ""{
                    self.matchDatesArray.append(singlePost["thirdMatchDate"] as! String)
                }
                
                if singlePost["fourthMatchDate"] as! String != ""{
                    self.matchDatesArray.append(singlePost["fourthMatchDate"] as! String)
                }
                
                if singlePost["firstMatchOdd"] as! String != ""{
                    self.matchOddsArray.append(singlePost["firstMatchOdd"] as! String)
                }
                
                if singlePost["secondMatchOdd"] as! String != ""{
                    self.matchOddsArray.append(singlePost["secondMatchOdd"] as! String)
                }
                
                if singlePost["thirdMatchOdd"] as! String != ""{
                    self.matchOddsArray.append(singlePost["thirdMatchOdd"] as! String)
                }
                
                if singlePost["fourthMatchOdd"] as! String != ""{
                    self.matchOddsArray.append(singlePost["fourthMatchOdd"] as! String)
                }
                
                if singlePost["firstMatchPredict"] as! String != ""{
                    self.matchPredictsArray.append(singlePost["firstMatchPredict"] as! String)
                }
                
                if singlePost["secondMatchPredict"] as! String != ""{
                    self.matchPredictsArray.append(singlePost["secondMatchPredict"] as! String)
                }
                
                if singlePost["thirdMatchPredict"] as! String != ""{
                    self.matchPredictsArray.append(singlePost["thirdMatchPredict"] as! String)
                }
                
                if singlePost["fourthMatchPredict"] as! String != ""{
                    self.matchPredictsArray.append(singlePost["fourthMatchPredict"] as! String)
                }
                
                if singlePost["isFirstMatchChecked"] as! String != ""{
                    self.matchStatusArray.append(singlePost["isFirstMatchChecked"] as! String)
                }
                
                if singlePost["isSecondMatchChecked"] as! String != ""{
                    self.matchStatusArray.append(singlePost["isSecondMatchChecked"] as! String)
                }
                
                if singlePost["isThirdMatchChecked"] as! String != ""{
                    self.matchStatusArray.append(singlePost["isThirdMatchChecked"] as! String)
                }
                
                if singlePost["isFourthMatchChecked"] as! String != ""{
                    self.matchStatusArray.append(singlePost["isFourthMatchChecked"] as! String)
                }
                
            //}
            self.tableView.reloadData()
        }
    }
}
