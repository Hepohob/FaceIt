//
//  EyeView.swift
//  FaceIt
//
//  Created by Aleksei Neronov on 30.12.16.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import UIKit

class EyeView: UIView {

    //MARK: Public API

    var lineWidth = CGFloat(5.0) { didSet{ setNeedsDisplay() }}
    var color = UIColor.blue { didSet{setNeedsDisplay() }}
    var _eyesOpen = false { didSet {setNeedsDisplay() }}
    var eyesOpen: Bool {
        get {
            return _eyesOpen
        }
        set {
            UIView.transition(with: self,
                              duration: 0.2,
                              options: [.transitionFlipFromTop,.curveLinear],
                              animations: { 
                                self._eyesOpen = newValue
            },
                              completion: nil)
        }
    }
    
    override func draw(_ rect: CGRect) {
        var path: UIBezierPath!

        if eyesOpen {
            path = UIBezierPath(ovalIn: bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2))
        }
        else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        }
        path.lineWidth = lineWidth
        color.setStroke()
        path.stroke()
    }
}
