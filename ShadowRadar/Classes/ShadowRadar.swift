//
//  ShadowRadar.swift
//  ShadowRadar
//
//  Created by Meng Li on 2019/02/18.
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

import UIKit
import ShapeView

fileprivate struct Const {
    
    static let vertex = Array(0 ... 5)
    static let angles: [CGFloat] = Const.vertex.map { .pi * (30.0 + 60.0 * CGFloat($0)) / 180.0 }

    static func points(center: CGPoint, radius: CGFloat) -> [CGPoint] {
        return Const.vertex.map {
            CGPoint(x: center.x + cos(Const.angles[$0]) * radius, y: center.y - sin(Const.angles[$0]) * radius)
        }
    }
    
}

extension UIBezierPath {
    
    func addPoints(_ points: [CGPoint]) {
        points.enumerated().forEach {
            if $0 == 0 {
                move(to: $1)
            } else {
                addLine(to: $1)
            }
        }
    }
    
}

public class ShadowRadar: UIView {
    
    private lazy var backgroundLayer: ShapeLayer = {
        let layer = ShapeLayer()
        layer.layerPath = .custom {
            let radius = self.bounds.width / 2
            let center = CGPoint(x: radius, y: radius)
            $0.addPoints(Const.points(center: center, radius: radius))
        }
        layer.backgroundColor = UIColor(white: 0.5, alpha: 0.3).cgColor
        layer.innerShadow = ShapeShadow(raduis: 10, color: .lightGray)
        layer.outerShadow = ShapeShadow(raduis: 20, color: .lightGray)
        return layer
    }()
    
    private lazy var levelLayer = CALayer()
    
    public var levels: Int? {
        didSet {
            guard let levels = levels, levels > 1 else {
                return
            }

            (1 ..< levels).map { levels - $0 }.forEach { level in
                let layer = ShapeLayer()
                layer.layerPath = .custom {
                    let radius = self.bounds.width / 2
                    let center = CGPoint(x: radius, y: radius)
                    let currentRadius = radius * CGFloat(level) / CGFloat(levels)
                    print(currentRadius)
                    $0.addPoints(Const.points(center: center, radius: currentRadius))
                }
                layer.innerShadow = ShapeShadow(raduis: 10, color: .lightGray)
                levelLayer.addSublayer(layer)
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(levelLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func starPath(in center: CGPoint, with radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.addPoints(Const.points(center: center, radius: radius))
        path.close()
        return path
    }
    
    public override var bounds: CGRect {
        didSet {
            backgroundLayer.frame = bounds
            levelLayer.frame = bounds
            levelLayer.sublayers?.forEach { $0.frame = bounds }
        }
    }
    
}
