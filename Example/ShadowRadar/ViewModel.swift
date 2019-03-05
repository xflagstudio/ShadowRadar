//
//  ViewModel.swift
//  ShadowRadar_Example
//
//  Created by Meng Li on 2019/02/21.
//  Copyright © 2019 XFLAG. All rights reserved.
//

import RxSwift
import RxCocoa
import ShadowRadar

class ViewModel {
    
    let maxLevel = BehaviorRelay<Int>(value: 5)
    let radar = PublishSubject<ShadowRadarChart.Radar>()
    let titles = PublishSubject<[String]>()
    let shadow = PublishSubject<ShadowRadarChart.Shadow>()
    let radarColor = PublishSubject<UIColor>()
    
    func updateLevelsButton() {
        maxLevel.accept(Int.random(in: 3 ... 8))

    }
    
    func updateRadar() {
        let levels = self.maxLevel.value
        radar.onNext(.init(levels: (0 ... levels).map { _ in Int.random(in: 1 ... levels)}, color: .random))
    }
    
    func updateTitles() {
        titles.onNext(["Alice", "Bob", "Carol", "Dave", "Eve", "Frank"].shuffled())
    }
    
    func updateRadarBackground() {
        shadow.onNext(.init(raduis: CGFloat.random(in: 5 ... 10), color: .random, opacity: Float.random(in: 0.5 ... 1)))
        radarColor.onNext(.random)
    }
    
}
