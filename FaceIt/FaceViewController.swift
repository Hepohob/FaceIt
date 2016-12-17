//
//  FaceViewController.swift
//  FaceIt
//
//  Created by Aleksei Neronov on 16/12/2016.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    var expression = FacialExpression(eyes: .closed, eyeBrows: .relaxed, mouth: .smirk) {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView,
                                                                   action: #selector(FaceView.changeScale(recognizer:))))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer (target: self,
                                                                          action: #selector(FaceViewController.increaseHappiness))
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer (target: self,
                                                                         action: #selector(FaceViewController.decreaseHappiness))
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            updateUI()
        }
    }
    
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private let mouthCurvature = [FacialExpression.Mouth.frown:-1.0,.grin:0.5,.smile:1.0,.smirk:-0.5,.neutral:0.0]
    private let eyeBrowTilt = [FacialExpression.EyeBrows.relaxed:0.5,.furrowed:-0.5,.normal:0.0]
    
    private func updateUI() {
        switch expression.eyes {
        case .open: faceView.eyesOpen = true
        case .closed: faceView.eyesOpen = false
        case .squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvature[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilt[expression.eyeBrows] ?? 0.0
        
    }
    
    
}

