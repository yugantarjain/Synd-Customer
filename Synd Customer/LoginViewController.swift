//
//  LoginViewController.swift
//  Synd Customer
//
//  Created by yugantar jain on 08/09/19.
//  Copyright © 2019 yugantar jain. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {// GIDSignInDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        //        GIDSignIn.sharedInstance().signIn()
        
        
//        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        // ...
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { (Auth, User) in
            if User != nil
            {
                self.performSegue(withIdentifier: "toMain", sender: self)
            }
        }
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
