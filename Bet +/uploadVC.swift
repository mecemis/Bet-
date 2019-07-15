//
//  uploadVC.swift
//  Bet +
//
//  Created by Murat on 13.12.2018.
//  Copyright © 2018 Murat. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import SCLAlertView

class uploadVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var firstMatchName: UITextField!
    @IBOutlet weak var firstMatchDate: UITextField!
    @IBOutlet weak var firstMatchOdd: UITextField!
    @IBOutlet weak var firstMatchLeague: UITextField!
    @IBOutlet weak var firstMatchPredict: UITextField!
    
    @IBOutlet weak var secondMatchName: UITextField!
    @IBOutlet weak var secondMatchDate: UITextField!
    @IBOutlet weak var secondMatchOdd: UITextField!
    @IBOutlet weak var secondMatchLeague: UITextField!
    @IBOutlet weak var secondMatchPredict: UITextField!
    
    @IBOutlet weak var thirdMatchName: UITextField!
    @IBOutlet weak var thirdMatchDate: UITextField!
    @IBOutlet weak var thirdMatchOdd: UITextField!
    @IBOutlet weak var thirdMatchLeague: UITextField!
    @IBOutlet weak var thirdMatchPredict: UITextField!
    
    @IBOutlet weak var fourthMatchName: UITextField!
    @IBOutlet weak var fourthMatchDate: UITextField!
    @IBOutlet weak var fourthMatchOdd: UITextField!
    @IBOutlet weak var fourthMatchLeague: UITextField!
    @IBOutlet weak var fourthMatchPredict: UITextField!
    
    @IBOutlet weak var matchTypes: UITextField!
    @IBOutlet weak var couponSystem: UITextField!
    @IBOutlet weak var couponTotalOdds: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard));
        view.addGestureRecognizer(tap);
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        if matchTypes.text == "" || couponSystem.text == "" || couponTotalOdds.text == "" || firstMatchName.text == "" {
            
            let alert = UIAlertController(title: "Hata", message: "Maç türü, Toplam oran ve Sistemi boş bırakma!!", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }else{
        
            let alert = UIAlertController(title: "Emin misin?", message: "Boşlukları bir gözden geçir bence", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Tekrar Bakayım", style: UIAlertAction.Style.cancel, handler: nil)
            let reviseButton = UIAlertAction(title: "Eminim Yolla", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let uuid = NSUUID().uuidString
                
                let databaseReference = Database.database().reference()
                
                let post = ["postedBy" : Auth.auth().currentUser?.email, "firstMatchName" : self.firstMatchName.text!, "firstMatchDate" : self.firstMatchDate.text!, "firstMatchOdd" : self.firstMatchOdd.text!, "firstMatchLeague" : self.firstMatchLeague.text!, "firstMatchPredict" : self.firstMatchPredict.text!, "secondMatchName" : self.secondMatchName.text!, "secondMatchDate" : self.secondMatchDate.text!, "secondMatchOdd" : self.secondMatchOdd.text!, "secondMatchLeague" : self.secondMatchLeague.text!, "secondMatchPredict" : self.secondMatchPredict.text!, "thirdMatchName" : self.thirdMatchName.text!, "thirdMatchDate" : self.thirdMatchDate.text!, "thirdMatchOdd" : self.thirdMatchOdd.text!, "thirdMatchLeague" : self.thirdMatchLeague.text!, "thirdMatchPredict" : self.thirdMatchPredict.text!, "fourthMatchName" : self.fourthMatchName.text!, "fourthMatchDate" : self.fourthMatchDate.text!, "fourthMatchOdd" : self.fourthMatchOdd.text!, "fourthMatchLeague" : self.fourthMatchLeague.text!, "fourthMatchPredict" : self.fourthMatchPredict.text!, "matchTypes" : self.matchTypes.text!, "couponSystem" : self.couponSystem.text!, "couponTotalOdds" : self.couponTotalOdds.text!, "isCouponChecked" : "stable" ,"isFirstMatchChecked" : "stable", "isSecondMatchChecked" : "stable", "isThirdMatchChecked" : "stable", "isFourthMatchChecked" : "stable", "uuid" : uuid] as [String : Any]
                
                databaseReference.child("users").child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(post)
                
                self.firstMatchName.text = ""
                self.firstMatchDate.text = ""
                self.firstMatchOdd.text = ""
                self.firstMatchLeague.text = ""
                self.firstMatchPredict.text = ""
                
                self.secondMatchName.text = ""
                self.secondMatchDate.text = ""
                self.secondMatchOdd.text = ""
                self.secondMatchLeague.text = ""
                self.secondMatchPredict.text = ""
                
                self.thirdMatchName.text = ""
                self.thirdMatchDate.text = ""
                self.thirdMatchOdd.text = ""
                self.thirdMatchLeague.text = ""
                self.thirdMatchPredict.text = ""
                
                self.fourthMatchName.text = ""
                self.fourthMatchDate.text = ""
                self.fourthMatchOdd.text = ""
                self.fourthMatchLeague.text = ""
                self.fourthMatchPredict.text = ""
                
                self.matchTypes.text = ""
                self.couponSystem.text = ""
                self.couponTotalOdds.text = ""
                
                
            }
        
        
            alert.addAction(okButton)
            alert.addAction(reviseButton)
            self.present(alert, animated: true, completion: nil)
        }
            
       /* let storage = Storage.storage()
        let storageRef = storage.reference()
        let uuid = NSUUID().uuidString
        
        let databaseReference = Database.database().reference()
        
        let post = ["postedBy" : Auth.auth().currentUser?.email, "firstMatchName" : firstMatchName.text!, "firstMatchDate" : firstMatchDate.text!, "firstMatchOdd" : firstMatchOdd.text!, "firstMatchLeague" : firstMatchLeague.text!, "firstMatchPredict" : firstMatchPredict.text!, "secondMatchName" : secondMatchName.text!, "secondMatchDate" : secondMatchDate.text!, "secondMatchOdd" : secondMatchOdd.text!, "secondMatchLeague" : secondMatchLeague.text!, "secondMatchPredict" : secondMatchPredict.text!, "thirdMatchName" : thirdMatchName.text!, "thirdMatchDate" : thirdMatchDate.text!, "thirdMatchOdd" : thirdMatchOdd.text!, "thirdMatchLeague" : thirdMatchLeague.text!, "thirdMatchPredict" : thirdMatchPredict.text!, "fourthMatchName" : fourthMatchName.text!, "fourthMatchDate" : fourthMatchDate.text!, "fourthMatchOdd" : fourthMatchOdd.text!, "fourthMatchLeague" : fourthMatchLeague.text!, "fourthMatchPredict" : fourthMatchPredict.text!, "matchTypes" : matchTypes.text!, "couponSystem" : couponSystem.text!, "couponTotalOdds" : couponTotalOdds.text!, "uuid" : uuid] as [String : Any]
        
        databaseReference.child("users").child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(post)
        }
   */
        
    }
    
}
