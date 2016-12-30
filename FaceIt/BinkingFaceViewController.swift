//
//  BinkingFaceViewController.swift
//  FaceIt
//
//  Created by Aleksei Neronov on 30.12.16.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import UIKit

class BinkingFaceViewController: FaceViewController {

    var blinking = false {
        didSet {
            startBlink()
        }
    }
    
    private struct BlinkRate {
        static let ClosedDuration = 0.4
        static let OpenDuration = 2.5
    }
    
    func startBlink() {
        if blinking {
            faceView.eyesOpen = false
            Timer.scheduledTimer(timeInterval: BlinkRate.ClosedDuration,
                                 target: self,
                                 selector: #selector(BinkingFaceViewController.endBlink),
                                 userInfo: nil,
                                 repeats: false)
        }
    }
    
    func endBlink() {
        faceView.eyesOpen = true
        Timer.scheduledTimer(timeInterval: BlinkRate.OpenDuration,
                             target: self,
                             selector: #selector(BinkingFaceViewController.startBlink),
                             userInfo: nil,
                             repeats: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = false
    }
}
