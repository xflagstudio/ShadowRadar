//
//  ShadowRadar.swift
//  ShadowRadar
//
//  Created by Meng Li  on 2019/02/18.
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

    private var screenPath: UIBezierPath?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateScreenPath() {
        screenPath = {
            let path = UIBezierPath()
            let main = UIScreen.main.bounds
            path.move(to: CGPoint(x: -frame.origin.x, y: -frame.origin.y))
            path.addLine(to: CGPoint(x: main.width - frame.origin.x, y: -frame.origin.y))
            path.addLine(to: CGPoint(x: main.width - frame.origin.x, y: main.height - frame.origin.y))
            path.addLine(to: CGPoint(x: -frame.origin.x, y: main.height - frame.origin.y))
            path.close()
            return path
        }()
    }
    
    private func starPath(in center: CGPoint, with radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.addPoints(Const.points(center: center, radius: radius))
        path.close()
        return path
    }
    
    public override var bounds: CGRect {
        didSet {
            let radius = bounds.width / 2
            let center = CGPoint(x: radius, y: radius)
            let path = starPath(in: center, with: radius)
            
            let shapLayer = CAShapeLayer()
            shapLayer.path = path.cgPath
            shapLayer.fillColor = UIColor.lightGray.cgColor
            
            layer.addSublayer(shapLayer)
            
            
            let shadowLayer = CAShapeLayer()
            shadowLayer.frame = bounds
            shadowLayer.shadowColor = UIColor.blue.cgColor
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowOpacity = 1
            shadowLayer.shadowRadius = 5
            shadowLayer.fillRule = .evenOdd
            
            // Define shadow path
            let shadowPath = UIBezierPath()
            shadowPath.append(path)
            shadowPath.append(starPath(in: center, with: radius * 0.9))

            shadowLayer.path = shadowPath.cgPath
            
            layer.addSublayer(shadowLayer)
        }
    }
    
}
