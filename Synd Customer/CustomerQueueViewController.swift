//
//  CustomerQueueViewController.swift
//  Synd Customer
//
//  Created by yugantar jain on 08/09/19.
//  Copyright © 2019 yugantar jain. All rights reserved.
//

import UIKit
import Starscream
import Foundation

class CustomerQueueViewController: UIViewController, WebSocketDelegate {
    
    var socket: WebSocket!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        socket = WebSocket.init(url: URL(string: "https://hack321.herokuapp.com")!)
        socket.delegate = self
        socket.connect()
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("connect")
        return
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("disconnect")
        return
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("string")
        return
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("data")
        return
    }
    
    @IBOutlet weak var queueNumber: UILabel!
    @IBOutlet weak var queueNumberMessage: UILabel!
    @IBOutlet weak var timeMessage: UILabel!
    @IBOutlet weak var counterMessage: UILabel!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
