//
//  ViewController.swift
//  ShadowRadar
//
//  Created by lm2343635 on 02/18/2019.
//  Copyright (c) 2019 lm2343635. All rights reserved.
//

import UIKit
import ShadowRadar

class ViewController: UIViewController {
    
    private lazy var radar = ShadowRadar(frame: CGRect(x: 100, y: 100, width: 100, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .black
        view.addSubview(radar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

