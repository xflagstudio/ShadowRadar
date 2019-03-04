//
//  ShadowTitleRadarChart.swift
//  ShadowRadar
//
//  Created by Meng Li on 2019/02/20.
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

public class ShadowTitleRadarChart: UIView {
    
    public enum TitleAlignment {
        case center
        case leftRight
    }

    private lazy var radarChart = ShadowRadarChart()
    
    private lazy var titleLabels = Const.vertex.map { _ -> UILabel in
        let label = UILabel()
        label.textAlignment = .center
        return label
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(radarChart)
        titleLabels.forEach { addSubview($0) }
    }
    
    public var maxLevel: Int? {
        didSet {
            radarChart.maxLevel = maxLevel
        }
    }
    
    public var radarsCount: Int = 0 {
        didSet {
            radarChart.radarsCount = radarsCount
        }
    }
    
    public var innerShadow: ShapeShadow = .init(raduis: 10, color: .lightGray) {
        didSet {
            radarChart.innerShadow = innerShadow
        }
    }
    
    public var outerShadow: ShapeShadow = .init(raduis: 10, color: .lightGray) {
        didSet {
            radarChart.outerShadow = outerShadow
        }
    }
    
    public var radarColor: UIColor? {
        didSet {
            radarChart.radarColor = radarColor
        }
    }
    
    public var titles: [String?] = [] {
        didSet {
            Const.vertex.forEach {
                guard 0 ..< titles.count ~= $0 else {
                    return
                }
                titleLabels[$0].text = titles[$0]
            }
        }
    }
    
    public var titleFont: UIFont? {
        didSet {
            guard let font = titleFont else {
                return
            }
            titleLabels.forEach { $0.font = font }
        }
    }
    
    public var titleColor: UIColor? {
        didSet {
            guard let color = titleColor else {
                return
            }
            titleLabels.forEach { $0.textColor = color }
        }
    }
    
    public var titleMinimumScaleFactor: CGFloat? {
        didSet {
            guard let scaleFactor = titleMinimumScaleFactor else {
                return
            }
            titleLabels.forEach {
                $0.minimumScaleFactor = scaleFactor
                $0.adjustsFontSizeToFitWidth = true
            }
        }
    }
    
    public var titleMargin: CGFloat = 5
    
    public var titleAlignment: TitleAlignment = .center
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var bounds: CGRect {
        didSet {
            createConstraints()
        }
    }
    
    private func createConstraints() {
        
        radarChart.translatesAutoresizingMaskIntoConstraints = false
        radarChart.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        radarChart.topAnchor.constraint(equalTo: titleLabels[0].bottomAnchor, constant: titleMargin).isActive = true
        radarChart.bottomAnchor.constraint(equalTo: titleLabels[3].topAnchor, constant: -titleMargin).isActive = true
        radarChart.widthAnchor.constraint(equalTo: radarChart.heightAnchor).isActive = true

        titleLabels[0].translatesAutoresizingMaskIntoConstraints = false
        titleLabels[0].centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabels[0].topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        titleLabels[3].translatesAutoresizingMaskIntoConstraints = false
        titleLabels[3].centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabels[3].bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        switch titleAlignment {
            
        case .center:
            let radarHeight = (bounds.height - 2.0 * titleLabels[0].font.lineHeight)
            let verticalOffset = radarHeight / 4.0
            let horizontalOffset = radarHeight * (1 - sin(.pi / 3.0)) / 2.0

            titleLabels[1].translatesAutoresizingMaskIntoConstraints = false
            titleLabels[1].rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            titleLabels[1].leftAnchor.constraint(equalTo: radarChart.rightAnchor, constant: -horizontalOffset).isActive = true
            titleLabels[1].centerYAnchor.constraint(equalTo: radarChart.centerYAnchor, constant: -verticalOffset).isActive = true
            
            titleLabels[2].translatesAutoresizingMaskIntoConstraints = false
            titleLabels[2].rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            titleLabels[2].leftAnchor.constraint(equalTo: radarChart.rightAnchor, constant: -horizontalOffset).isActive = true
            titleLabels[2].centerYAnchor.constraint(equalTo: radarChart.centerYAnchor, constant: verticalOffset).isActive = true
            
            titleLabels[4].translatesAutoresizingMaskIntoConstraints = false
            titleLabels[4].rightAnchor.constraint(equalTo: radarChart.leftAnchor, constant: horizontalOffset).isActive = true
            titleLabels[4].leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            titleLabels[4].centerYAnchor.constraint(equalTo: radarChart.centerYAnchor, constant: verticalOffset).isActive = true
            
            titleLabels[5].translatesAutoresizingMaskIntoConstraints = false
            titleLabels[5].rightAnchor.constraint(equalTo: radarChart.leftAnchor, constant: horizontalOffset).isActive = true
            titleLabels[5].leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            titleLabels[5].centerYAnchor.constraint(equalTo: radarChart.centerYAnchor, constant: -verticalOffset).isActive = true
        case .leftRight:
            
            titleLabels.enumerated().forEach {
                switch $0 {
                case 1, 2:
                    $1.textAlignment = .left
                case 4, 5:
                    $1.textAlignment = .right
                default:
                    $1.textAlignment = .center
                }
            }
            
            let radarHeight = (bounds.height - 2.0 * titleLabels[0].font.lineHeight)
            let radius = radarHeight / 2.0 + titleMargin
            let verticalOffset = radius * sin(.pi / 6.0)
            let horizontalOffset = radius * cos(.pi / 6.0)
            
            titleLabels[1].translatesAutoresizingMaskIntoConstraints = false
            titleLabels[1].rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            titleLabels[1].leftAnchor.constraint(equalTo: radarChart.centerXAnchor, constant: horizontalOffset).isActive = true
            titleLabels[1].centerYAnchor.constraint(equalTo: radarChart.centerYAnchor, constant: -verticalOffset).isActive = true

            titleLabels[2].translatesAutoresizingMaskIntoConstraints = false
            titleLabels[2].rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            titleLabels[2].leftAnchor.constraint(equalTo: radarChart.centerXAnchor, constant: horizontalOffset).isActive = true
            titleLabels[2].centerYAnchor.constraint(equalTo: radarChart.centerYAnchor, constant: verticalOffset).isActive = true

            titleLabels[4].translatesAutoresizingMaskIntoConstraints = false
            titleLabels[4].rightAnchor.constraint(equalTo: radarChart.centerXAnchor, constant: -horizontalOffset).isActive = true
            titleLabels[4].leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            titleLabels[4].centerYAnchor.constraint(equalTo: radarChart.centerYAnchor, constant: verticalOffset).isActive = true

            titleLabels[5].translatesAutoresizingMaskIntoConstraints = false
            titleLabels[5].rightAnchor.constraint(equalTo: radarChart.centerXAnchor, constant: -horizontalOffset).isActive = true
            titleLabels[5].leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            titleLabels[5].centerYAnchor.constraint(equalTo: radarChart.centerYAnchor, constant: -verticalOffset).isActive = true
        }
        
    }
    
    public func addRadar(_ radar: Radar) {
        radarChart.addRadar(radar)
    }
    
    public func removeRadar(at index: Int) {
        radarChart.removeRadar(at: index)
    }
    
    public func updateRadar(_ radar: Radar, at index: Int) {
        radarChart.updateRadar(radar, at: index)
    }
    
}
