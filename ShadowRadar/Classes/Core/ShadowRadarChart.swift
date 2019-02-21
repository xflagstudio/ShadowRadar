//
//  ShadowRadarChart.swift
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

struct Const {
    
    static let vertex = Array(0 ... 5)
    static let angles: [CGFloat] = [90, 30, 330, 270, 210, 150].map { .pi * CGFloat($0) / 180.0 }

    static func points(center: CGPoint, radius: CGFloat) -> [CGPoint] {
        return Const.vertex.map {
            CGPoint(
                x: center.x + cos(Const.angles[$0]) * radius,
                y: center.y - sin(Const.angles[$0]) * radius
            )
        }
    }
    
    static func points(center: CGPoint, radius: CGFloat, levels: [Int], maxLevel: Int) -> [CGPoint] {
        return Const.vertex.map {
            (0 ..< levels.count ~= $0) ? levels[$0] : maxLevel
        }.map {
            CGFloat((1 ..< maxLevel ~= $0) ? $0 : maxLevel)
        }.enumerated().map { index, level in
            let angle = Const.angles[index]
            let radio = level / CGFloat(maxLevel)
            return CGPoint(
                x: center.x + cos(angle) * radius * radio,
                y: center.y - sin(angle) * radius * radio
            )
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

public struct Radar {
    var levels: [Int]
    var color: UIColor
    
    public init(levels: [Int], color: UIColor) {
        self.levels = levels
        self.color = color
    }
}

public class ShadowRadarChart: UIView {
    
    private var chartLayers: [CAShapeLayer] = []
    
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
    
    private lazy var radarLayer = CALayer()
    private lazy var levelLayer = CALayer()
    
    public var maxLevel: Int? {
        didSet {
            guard let maxLevel = maxLevel, maxLevel > 1 else {
                return
            }
            radarLayer.sublayers?.forEach { $0.removeFromSuperlayer() }

            (1 ..< maxLevel).map { maxLevel - $0 }.forEach { level in
                let layer = ShapeLayer()
                layer.layerPath = .custom {
                    let radius = self.bounds.width / 2
                    let center = CGPoint(x: radius, y: radius)
                    let currentRadius = radius * CGFloat(level) / CGFloat(maxLevel)
                    $0.addPoints(Const.points(center: center, radius: currentRadius))
                }
                layer.innerShadow = ShapeShadow(raduis: 10, color: .lightGray)
                radarLayer.addSublayer(layer)
            }
            
            if bounds != .zero {
                radarLayer.sublayers?.forEach { $0.frame = bounds }
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(radarLayer)
        layer.addSublayer(levelLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var bounds: CGRect {
        didSet {
            backgroundLayer.frame = bounds
            radarLayer.frame = bounds
            radarLayer.sublayers?.forEach { $0.frame = bounds }
            levelLayer.frame = bounds
            levelLayer.sublayers?.forEach { $0.frame = bounds }
        }
    }
    
    private func starPath(in center: CGPoint, with radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.addPoints(Const.points(center: center, radius: radius))
        path.close()
        return path
    }
    
    private func setRadar(_ radar: Radar, for layer: ShapeLayer) {
        let max = maxLevel ?? 1
        layer.layerPath = .custom {
            let radius = self.bounds.width / 2
            let points = Const.points(
                center: CGPoint(x: radius, y: radius),
                radius: radius,
                levels: radar.levels,
                maxLevel: max
            )
            $0.addPoints(points)
        }
        layer.backgroundColor = radar.color.cgColor
    }
    
    private func findChartLayer(at index: Int) -> ShapeLayer? {
        guard
            let sublayers = levelLayer.sublayers,
            0 ..< sublayers.count ~= index,
            let chartLayer = sublayers[index] as? ShapeLayer
        else {
            NSLog("[ShadowRadar] Cannot find a layer with index %d", index)
            return nil
        }
        return chartLayer
    }
    
    public func addRadar(_ radar: Radar) {
        let layer = ShapeLayer()
        setRadar(radar, for: layer)
        levelLayer.addSublayer(layer)
    }
    
    public func removeRadar(at index: Int) {
        findChartLayer(at: index)?.removeFromSuperlayer()
    }
    
    public func updateRadar(_ radar: Radar, at index: Int) {
        if let layer = findChartLayer(at: index) {
            setRadar(radar, for: layer)
        }
    }
    
}
