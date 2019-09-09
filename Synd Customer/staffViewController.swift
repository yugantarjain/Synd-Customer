//
//  staffViewController.swift
//  Synd Customer
//
//  Created by yugantar jain on 08/09/19.
//  Copyright © 2019 yugantar jain. All rights reserved.
//

import UIKit

var hniLabelText = "No HNI customer present right now"

class staffViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        hniLabel.text = hniLabelText
    }
    
    @IBAction func next(_ sender: Any) {
        let url = URL(string: "https://hack321.herokuapp.com/next")
        var req = URLRequest.init(url: url!)
        req.httpMethod = "POST"
        URLSession.shared.dataTask(with: req) { (d, r, e) in
            return
        }.resume()
    }
    
    
    @IBOutlet weak var hniLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
