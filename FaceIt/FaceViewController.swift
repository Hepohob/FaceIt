//
//  FaceViewController.swift
//  FaceIt
//
//  Created by Aleksei Neronov on 16/12/2016.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
//MARK: Model
    var expression = FacialExpression(eyes: .closed, eyeBrows: .relaxed, mouth: .smirk) {
        didSet {
            updateUI()
        }
    }
    
    private struct Animation {
        static let ShakeAngle = CGFloat(M_PI/6)
        static let ShakeDuration = 0.3
    }
    
//MARK: View
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended{
            switch expression.eyes {
            case .open:
                expression.eyes = .closed
            case .closed:
                expression.eyes = .open
            case .squinting:
                break
            }
        }
    }
    
    @IBAction func headShake(_ sender: UITapGestureRecognizer)
    {
        UIView.animate(
            withDuration: Animation.ShakeDuration,
            animations: {
                self.faceView.transform = self.faceView.transform.rotated(by: Animation.ShakeAngle)
        },
            completion: { finished in
                if finished {
                    UIView.animate(
                        withDuration: Animation.ShakeDuration * 2,
                        animations: {
                            self.faceView.transform = self.faceView.transform.rotated(by: -Animation.ShakeAngle * 2)
                    },
                        completion: { finished in
                            if finished {
                                UIView.animate(
                                    withDuration: Animation.ShakeDuration,
                                    animations: {
                                        self.faceView.transform = self.faceView.transform.rotated(by: Animation.ShakeAngle)
                                },
                                    completion: { finished in
                                        if finished {
                                            
                                        }
                                }
                                )
                            }
                    }
                    )
                }
        }
        )
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
        case .open: faceView?.eyesOpen = true
        case .closed: faceView?.eyesOpen = false
        case .squinting: faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvature[expression.mouth] ?? 0.0
        faceView?.eyeBrowTilt = eyeBrowTilt[expression.eyeBrows] ?? 0.0
        
    }
    
    
}

