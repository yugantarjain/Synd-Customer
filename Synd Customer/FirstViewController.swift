//
//  FirstViewController.swift
//  Synd Customer
//
//  Created by yugantar jain on 28/08/19.
//  Copyright © 2019 yugantar jain. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController {
    
    //IB
    @IBAction func EnableAutomaticCheckIn(_ sender: UIButton) {
        enableLocationServices()
    }
    //view
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //Methods
    func enableLocationServices() {
        let locationManager = CLLocationManager.init()
        locationManager.requestWhenInUseAuthorization()
    }

}

