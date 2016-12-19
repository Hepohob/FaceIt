//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Aleksei Neronov on 19/12/2016.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "angry" :  FacialExpression(eyes: .closed, eyeBrows: .furrowed, mouth: .frown),
        "happy" :  FacialExpression(eyes: .open, eyeBrows: .normal, mouth: .smile),
        "worried" :  FacialExpression(eyes: .open, eyeBrows: .relaxed, mouth: .smirk),
        "mischievious" :  FacialExpression(eyes: .open, eyeBrows: .furrowed, mouth: .grin)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Emotions"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        if let naVC = destinationVC as? UINavigationController {
            destinationVC = naVC.visibleViewController ?? destinationVC
        }
        if let faceVC = destinationVC as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    faceVC.expression = expression
                    if let sendButton = sender as? UIButton {
                        faceVC.title = sendButton.currentTitle
                    }
                }
            }
        }
    }

}
