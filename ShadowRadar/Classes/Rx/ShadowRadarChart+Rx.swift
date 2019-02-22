//
//  ShadowRadarChart+Rx.swift
//  ShadowRadar
//
//  Created by Meng Li on 2019/02/21.
//  Copyright © 2018 XFLAG. All rights reserved.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import RxSwift
import RxCocoa
import ShapeView

public extension Reactive where Base: ShadowRadarChart {
    
    public var maxLevel: Binder<Int> {
        return Binder(self.base) { (chart, maxLevel) in
            chart.maxLevel = maxLevel
        }
    }
    
    public func radar(at index: Int) -> Binder<Radar> {
        return Binder(self.base) { (chart, radar) in
            chart.updateRadar(radar, at: index)
        }
    }
    
    public var innerShadow: Binder<ShapeShadow> {
        return Binder(self.base) { (chart, innerShadow) in
            chart.innerShadow = innerShadow
        }
    }
    
    public var outerShadow: Binder<ShapeShadow> {
        return Binder(self.base) { (chart, outerShadow) in
            chart.outerShadow = outerShadow
        }
    }
    
    public var radarColor: Binder<UIColor?> {
        return Binder(self.base) { (chart, radarColor) in
            chart.radarColor = radarColor
        }
    }
    
}
