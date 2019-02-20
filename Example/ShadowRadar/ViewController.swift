//
//  ViewController.swift
//  ShadowRadar
//
//  Created by Meng Li on 2019/02/19.
//  Copyright © 2018 XFLAG. All rights reserved.
//

import UIKit
import SnapKit
import ShadowRadar

class ViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "background.jpg")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(frame: view.bounds)
        effectView.effect = UIBlurEffect(style: .dark)
        effectView.alpha = 0.8
        return effectView
    }()
    
    private lazy var radar: ShadowRadar = {
        let radar = ShadowRadar()
        radar.maxLevel = 4
        radar.addRadar(levels: [3, 2, 3, 4, 3, 1], color: UIColor(white: 1, alpha: 0.75))
        radar.addRadar(levels: [3, 4, 3, 3, 3, 2], color: UIColor(white: 0.5, alpha: 0.75))
        return radar
    }()
    
    private lazy var titleRadar: ShadowTitleRadar = {
        let radar = ShadowTitleRadar()
        radar.maxLevel = 4
        radar.addRadar(levels: [3, 2, 3, 4, 3, 1], color: UIColor(white: 1, alpha: 0.75))
        radar.addRadar(levels: [3, 4, 3, 3, 3, 2], color: UIColor(white: 0.5, alpha: 0.75))
        radar.titles = ["Title1", "Title2", "Title3", "Title4", "Title5", "Title6"]
        radar.titleFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        radar.titleColor = .white
        return radar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundImageView)
        view.addSubview(blurView)
        view.addSubview(radar)
        view.addSubview(titleRadar)
        createConstraints()
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    private func createConstraints() {
        
        radar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(radar.snp.width)
            
        }
        
        titleRadar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(radar.snp.bottom).offset(20)
            $0.height.equalTo(radar)
            $0.width.equalTo(radar.snp.width).multipliedBy(1.5)
        }
        
    }
    
}

