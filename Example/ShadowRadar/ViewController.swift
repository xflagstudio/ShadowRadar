//
//  ViewController.swift
//  ShadowRadar
//
//  Created by Meng Li on 2019/02/19.
//  Copyright © 2019 XFLAG. All rights reserved.
//

import UIKit
import SnapKit
import ShadowRadar
import RxSwift

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
    
    private lazy var radarChart: ShadowRadarChart = {
        let chart = ShadowRadarChart()
        chart.maxLevel = 4
        chart.addRadar(Radar(levels: [3, 2, 3, 4, 3, 1], color: UIColor(white: 1, alpha: 0.75)))
        chart.addRadar(Radar(levels: [3, 4, 3, 3, 3, 2], color: UIColor(white: 0.5, alpha: 0.75)))
        return chart
    }()
    
    private lazy var titleRadarChart: ShadowTitleRadarChart = {
        let chart = ShadowTitleRadarChart()
        chart.maxLevel = 4
        chart.addRadar(Radar(levels: [3, 2, 3, 4, 3, 1], color: UIColor(white: 1, alpha: 0.75)))
        chart.addRadar(Radar(levels: [3, 4, 3, 3, 3, 2], color: UIColor(white: 0.5, alpha: 0.75)))
        chart.titles = ["Title1", "Title2", "Title3", "Title4", "Title5", "Title6"]
        chart.titleFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        chart.titleColor = .white
        chart.titleMargin = 10
        return chart
    }()
    
    private lazy var updateLevelsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update Max Levels", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.rx.tap.bind { [unowned self] in
            self.viewModel.updateLevelsButton()
        }.disposed(by: disposeBag)
        return button
    }()
    
    private lazy var updateChartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update Chart", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.rx.tap.bind { [unowned self] in
            self.viewModel.updateRadar()
        }.disposed(by: disposeBag)
        return button
    }()
    
    private let viewModel: ViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundImageView)
        view.addSubview(blurView)
        view.addSubview(radarChart)
        view.addSubview(titleRadarChart)
        view.addSubview(updateLevelsButton)
        view.addSubview(updateChartButton)
        createConstraints()
        
        viewModel.maxLevels.bind(to: radarChart.rx.maxLevel).disposed(by: disposeBag)
        viewModel.radar.bind(to: radarChart.rx.radar(at: 1)).disposed(by: disposeBag)
    }

    private func createConstraints() {
        
        radarChart.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(radarChart.snp.width)
            
        }
        
        titleRadarChart.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(radarChart.snp.bottom).offset(20)
            $0.height.equalTo(radarChart)
            $0.width.equalTo(radarChart.snp.width).multipliedBy(1.5)
        }
        
        updateLevelsButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(titleRadarChart.snp.bottom).offset(20)
            $0.height.equalTo(44)
        }
        
        updateChartButton.snp.makeConstraints {
            $0.size.equalTo(updateLevelsButton)
            $0.centerX.equalTo(updateLevelsButton)
            $0.top.equalTo(updateLevelsButton.snp.bottom).offset(20)
        }
        
    }
    
}

