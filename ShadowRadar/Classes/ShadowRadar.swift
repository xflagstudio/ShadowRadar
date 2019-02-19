
import UIKit

fileprivate struct Const {
    static let vertex = Array(0 ... 5)
}

public class ShadowRadar: UIView {
    
    private var radius: CGFloat = 40.0
    private var angles: [CGFloat] = Const.vertex.map { .pi * (30.0 + 60.0 * CGFloat($0)) / 180.0 }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineWidth(2)
        context.setStrokeColor(UIColor(white: 0.5, alpha: 0.1).cgColor)
        
        context.beginPath()
        context.move(to: CGPoint(x: center.x + cos(angles[0]) * radius, y: center.y - sin(angles[0]) * radius))
        
        for i in 1..<6 {
            let point = CGPoint(x: center.x + cos(angles[i]) * radius, y: center.y - sin(angles[i]) * radius)
            context.addLine(to: point)
        }
        context.closePath()
        context.strokePath()
        
        context.beginPath()
        context.move(to: CGPoint(x: center.x + cos(angles[0]) * radius * 0.66, y: center.y - sin(angles[0]) * radius * 0.66))
        
        for i in 1..<6 {
            let point = CGPoint(x: center.x + cos(angles[i]) * radius * 0.66, y: center.y - sin(angles[i]) * radius * 0.66)
            context.addLine(to: point)
        }
        context.closePath()
        context.strokePath()
        
        context.beginPath()
        context.move(to: CGPoint(x: center.x + cos(angles[0]) * radius * 0.33, y: center.y - sin(angles[0]) * radius * 0.33))
        
        for i in 1..<6 {
            let point = CGPoint(x: center.x + cos(angles[i]) * radius * 0.33, y: center.y - sin(angles[i]) * radius * 0.33)
            context.addLine(to: point)
        }
        context.closePath()
        context.strokePath()
        
        
        context.beginPath()
        let rnd = CGFloat.random(in: 0.5..<1)
        context.move(to: CGPoint(x: center.x + cos(angles[0]) * radius * rnd, y: center.y - sin(angles[0]) * radius * rnd))
        
        for i in 1..<6 {
            let rnd1 = CGFloat.random(in: 0.5..<1)
            let point = CGPoint(x: center.x + cos(angles[i]) * radius * rnd1, y: center.y - sin(angles[i]) * radius * rnd1)
            context.addLine(to: point)
        }
        context.closePath()
        context.setFillColor(UIColor(white: 0.5, alpha: 0.8).cgColor)
        context.fillPath()
        
        UIGraphicsEndImageContext()
    }
 
    
}
