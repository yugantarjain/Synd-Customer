//
//  HNIViewController.swift
//  Synd Customer
//
//  Created by yugantar jain on 09/09/19.
//  Copyright © 2019 yugantar jain. All rights reserved.
//

import UIKit
import FirebaseAuth

class HNIViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        welcomeLabel.text = "Welcome, \(Auth.auth().currentUser?.displayName ?? "")"
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
