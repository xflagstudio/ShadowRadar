//
//  ViewModel.swift
//  ShadowRadar_Example
//
//  Created by Meng Li on 2019/02/21.
//  Copyright © 2019 XFLAG. All rights reserved.
//

import RxSwift

class ViewModel {
    
    let maxLevel = PublishSubject<Int>()
    
    func updateLevelsButton() {
        maxLevel.onNext(Int.random(in: 3 ... 8))
    }
    
}
