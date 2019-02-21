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
    let radar = PublishSubject<Radar>()
    
    func updateLevelsButton() {
        maxLevel.accept(Int.random(in: 3 ... 8))

    }
    
    func updateRadar() {
        let levels = self.maxLevel.value
        radar.onNext(Radar(levels: (0 ... levels).map { _ in Int.random(in: 1 ... levels)}, color: .random))
    }
    
}
