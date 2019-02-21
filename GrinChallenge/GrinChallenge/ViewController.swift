//
//  ViewController.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/17/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "ShowTabView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTabView"{
            print("ShowTabView")
        }
    }


}

