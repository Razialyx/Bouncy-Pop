//
//  SplashViewController.swift
//  Bouncy Pop
//
//  Created by HPro2 on 4/25/22.
//

import UIKit

class SplashController: UIViewController {
    @IBOutlet weak var background: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(background)
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "purpleLoginBackground.png")!)
//        assignbackground()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "OpenMenu", sender: nil)
        }
    }
    
}
