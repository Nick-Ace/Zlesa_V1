//
//  ViewController.swift
//  Zlesa_V1
//
//  Created by Nikesh Hyanju on 12/14/17.
//  Copyright © 2017 zlesa. All rights reserved.
//

import UIKit

class Create_Post: UIViewController {

   
    @IBOutlet weak var viewCreatePost: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewCreatePost.layer.cornerRadius = 3
        viewCreatePost.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

