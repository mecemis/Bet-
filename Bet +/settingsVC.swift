//
//  SecondViewController.swift
//  Bet +
//
//  Created by Murat on 13.12.2018.
//  Copyright © 2018 Murat. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import MBProgressHUD

class settingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        
        refresh()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! settingsCell
        
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        switch indexPath.row {
        case 0:
            
            if Auth.auth().currentUser != nil{
            cell.settingsImage.image = UIImage(named: "logout.png")
            cell.settingsLabel.text = "Logout"
            
            return cell
            }else {
                cell.settingsLabel.text = "Sign In"
                cell.settingsImage.image = UIImage(named: "signIn.png")
                
            }
        default:
            return cell
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            
            MBProgressHUD.showAdded(to: self.view, animated: true);
            UIApplication.shared.beginIgnoringInteractionEvents();
            
            if Auth.auth().currentUser != nil{
            
            UserDefaults.standard.removeObject(forKey: "user")
            UserDefaults.standard.synchronize()
            
            let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signInID") as! signInVC
            
            let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            //başlangıç VC in yerini değiştirdik
            delegate.window?.rootViewController = signIn
            
            delegate.rememberUser()
            
            do {
                try Auth.auth().signOut()
                
                MBProgressHUD.hide(for: self.view, animated: true);
                UIApplication.shared.endIgnoringInteractionEvents();
                
            }catch{
                print("error")
            }
            }else{
                
                MBProgressHUD.showAdded(to: self.view, animated: true);
                UIApplication.shared.beginIgnoringInteractionEvents();
                
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "signInID") as! signInVC;
                
                
                self.present(vc, animated: true, completion: nil);
                
                MBProgressHUD.hide(for: self.view, animated: true);
                UIApplication.shared.endIgnoringInteractionEvents();
            }
            MBProgressHUD.hide(for: self.view, animated: true);
            UIApplication.shared.endIgnoringInteractionEvents();
            
        default:
            return
            
            
        }
       
        
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

  
    


}

