//
//  CustomerQueueViewController.swift
//  Synd Customer
//
//  Created by yugantar jain on 08/09/19.
//  Copyright © 2019 yugantar jain. All rights reserved.
//

import UIKit
import FirebaseAuth

struct DataUser: Decodable {
    let message: Int?
}

class CustomerQueueViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        welcomeLabel.text = "Welcome, \((Auth.auth().currentUser?.displayName)!)"
        
        getPosition()
    }
    
    @IBOutlet weak var queueNumber: UILabel!
    @IBOutlet weak var queueNumberMessage: UILabel!
    @IBOutlet weak var timeMessage: UILabel!
    @IBOutlet weak var counterMessage: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    func getPosition() {
        let urlString = "https://hack321.herokuapp.com/position"
        let url = URL(string: urlString)
        var request = URLRequest.init(url: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let email = Auth.auth().currentUser?.email
        let user = User.init(email: email)
        guard let uploadData = try? JSONEncoder().encode(user) else { return }
        
        URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
            }
            //api success
            guard let json = try? JSONDecoder().decode(DataUser.self, from: data!) else {
                DispatchQueue.main.async {
                    self.queueNumber.text = "-"
                    self.queueNumberMessage.text = "Currently, there are - people ahead of you in the queue"
                    self.timeMessage.text = "Your turn should come within - minutes"
                    self.counterMessage.text = "On arrival of your turn, kindly proceed towards counter number -"
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5, execute: {
                    self.navigationController?.popToRootViewController(animated: true)
                })
                return
            }
            DispatchQueue.main.async {
                let number = json.message!
                self.queueNumber.text = String(number)
                self.queueNumberMessage.text = "Currently, there are \(number) people ahead of you in the queue"
                self.timeMessage.text = "Your turn should come within \(number*7) minutes"
                self.counterMessage.text = "On arrival of your turn, kindly proceed towards counter number \(number/2 + 1)"
            }
        }.resume()
    }
    
    @IBAction func refersh(_ sender: Any) {
        getPosition()
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
