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
import SnapKit

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
        
        radarChart.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabels[0].snp.bottom).offset(titleMargin)
            $0.bottom.equalTo(titleLabels[3].snp.top).offset(-titleMargin)
            $0.width.equalTo(radarChart.snp.height)
        }
        
        titleLabels[0].snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        titleLabels[3].snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        switch titleAlignment {
            
        case .center:
            let radarHeight = (bounds.height - 2.0 * titleLabels[0].font.lineHeight)
            let verticalOffset = radarHeight / 4.0
            let horizontalOffset = radarHeight * (1 - sin(.pi / 3.0)) / 2.0
            
            titleLabels[1].snp.makeConstraints {
                $0.right.equalToSuperview()
                $0.left.equalTo(radarChart.snp.right).offset(-horizontalOffset)
                $0.centerY.equalTo(radarChart).offset(-verticalOffset)
            }
            
            titleLabels[2].snp.makeConstraints {
                $0.right.equalToSuperview()
                $0.left.equalTo(radarChart.snp.right).offset(-horizontalOffset)
                $0.centerY.equalTo(radarChart).offset(verticalOffset)
            }
            
            titleLabels[4].snp.makeConstraints {
                $0.left.equalToSuperview()
                $0.right.equalTo(radarChart.snp.left).offset(horizontalOffset)
                $0.centerY.equalTo(radarChart).offset(verticalOffset)
            }
            
            titleLabels[5].snp.makeConstraints {
                $0.left.equalToSuperview()
                $0.right.equalTo(radarChart.snp.left).offset(horizontalOffset)
                $0.centerY.equalTo(radarChart).offset(-verticalOffset)
            }
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
            
            titleLabels[1].snp.makeConstraints {
                $0.right.equalToSuperview()
                $0.left.equalTo(radarChart.snp.centerX).offset(horizontalOffset)
                $0.centerY.equalTo(radarChart).offset(-verticalOffset)
            }
            
            titleLabels[2].snp.makeConstraints {
                $0.right.equalToSuperview()
                $0.left.equalTo(radarChart.snp.centerX).offset(horizontalOffset)
                $0.centerY.equalTo(radarChart).offset(verticalOffset)
            }
            
            titleLabels[4].snp.makeConstraints {
                $0.left.equalToSuperview()
                $0.right.equalTo(radarChart.snp.centerX).offset(-horizontalOffset)
                $0.centerY.equalTo(radarChart).offset(verticalOffset)
            }
            
            titleLabels[5].snp.makeConstraints {
                $0.left.equalToSuperview()
                $0.right.equalTo(radarChart.snp.centerX).offset(-horizontalOffset)
                $0.centerY.equalTo(radarChart).offset(-verticalOffset)
            }
        }
        
    }
    
    public func addRadar(_ radar: Radar) {
        radarChart.addRadar(radar)
    }
    
    public func removeRadar(at index: Int) {
        
    }
    
    public func updateRadar(_ radar: Radar, at index: Int) {
        radarChart.updateRadar(radar, at: index)
    }
    
}
