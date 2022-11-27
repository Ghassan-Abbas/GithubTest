//
//  ViewController.swift
//  GithubTest
//
//  Created by MacAdmin on 27/11/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        label.textColor = .red
        
        label.text = "Hello final main"
    }


}

