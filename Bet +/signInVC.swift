//
//  signInVC.swift
//  Bet +
//
//  Created by Murat on 17.12.2018.
//  Copyright © 2018 Murat. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase
import FirebaseAuth
import MBProgressHUD

class signInVC: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var newAccButton: UIButton!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var isNewAcc = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5
        newAccButton.layer.cornerRadius = 5
        guestButton.layer.cornerRadius = 5

        refresh()
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard));
        view.addGestureRecognizer(tap);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isNewAcc = false
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
        let backgroundLayer = colors.gl
        backgroundLayer!.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        //performSegue(withIdentifier: "toTabBar", sender: nil)
        
        if isNewAcc == false{
            login()
        }else{
            signUp()
        }
        
    }
    
    @IBAction func newAccClicked(_ sender: Any) {
        
        //performSegue(withIdentifier: "toSignUpVC", sender: nil)
        
        if isNewAcc == false{
            
            changeTextsToSignUp()
            
            isNewAcc = true
            
         
        }else{
            
            changeTextsToLogin()
            
            isNewAcc = false
            
        }
        
        
        
    }
    
    @IBAction func guestClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toTabBar", sender: nil)
    }
    
    func login(){
        dismissKeyboard();
        
        if (emailText.text == "" || passwordText.text == ""){
            SCLAlertView().showError("Error", subTitle: "Please Fill All The Fields")
        }else{
            
            MBProgressHUD.showAdded(to: self.view, animated: true);
            UIApplication.shared.beginIgnoringInteractionEvents();
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (userdata, error) in
                
                MBProgressHUD.hide(for: self.view, animated: true);
                UIApplication.shared.endIgnoringInteractionEvents();
                
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    
                    UserDefaults.standard.set(userdata!.user.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    delegate.rememberUser()
                    
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    
                }
            }
        }
    }
    
    func signUp(){
        
        dismissKeyboard()
        
        if (emailText.text == "" || passwordText.text == ""){
            SCLAlertView().showError("Error", subTitle: "Please Fill All The Fields")
        }else{
            
            MBProgressHUD.showAdded(to: self.view, animated: true);
            UIApplication.shared.beginIgnoringInteractionEvents();
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (userdata, error) in
                
                MBProgressHUD.hide(for: self.view, animated: true);
                UIApplication.shared.endIgnoringInteractionEvents();
                
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    UserDefaults.standard.set(userdata!.user.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    delegate.rememberUser()
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
    }
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func changeTextsToLogin(){
        titleLabel.text = "Login With E-mail"
        loginButton.setTitle("Login", for: .normal)
        newAccButton.setTitle("New Account", for: .normal)
        
    }
    
    func changeTextsToSignUp(){
        titleLabel.text = "Create New Account"
        loginButton.setTitle("Sign Up", for: .normal)
        newAccButton.setTitle("Login With E-mail", for: .normal)
    }
    
}
