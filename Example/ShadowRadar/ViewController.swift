//
//  ViewController.swift
//  ShadowRadar
//
//  Created by lm2343635 on 02/18/2019.
//  Copyright (c) 2019 lm2343635. All rights reserved.
//

import UIKit
import SnapKit
import ShadowRadar

class ViewController: UIViewController {
    
    private lazy var radar = ShadowRadar()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(radar)
        createConstraints()
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        radar.addInnerShadow(shadowColor: .red, shadowSize: 5, shadowOpacity: 1)
    }

    private func createConstraints() {
        radar.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(radar.snp.width)
        }
    }
    
}

