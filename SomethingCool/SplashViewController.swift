//
//  SplashViewController.swift
//  Bouncy Pop
//
//  Created by HPro2 on 4/25/22.
//

import UIKit

class SplashController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.performSegue(withIdentifier: "OpenMenu", sender: nil)
        }
    }
}
