//
//  ViewController.swift
//  ProjectTune
//
//  Created by Michael Latman on 2/16/18.
//  Copyright © 2018 GroupTune. All rights reserved.
//

import UIKit

import ChameleonFramework

class PNNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barStyle = UIBarStyle.black
      
        self.hidesNavigationBarHairline = true
        self.setStatusBarStyle(.lightContent)
        let textAttributes = [NSAttributedStringKey.foregroundColor:Colors.primaryColor]
        self.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationBar.largeTitleTextAttributes = textAttributes
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

