//
//  StartViewController.swift
//  Bouncy Pop
//
//  Created by HPro2 on 4/21/22.
//

import Foundation
import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(background)
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func startGamePressed(_ sender: Any) {
        var player: Player
        
        if let newName = userNameTextField.text {
            if let newPassword = passwordTextField.text {
                player = Player(name: newName, password: newPassword)
                
                let defaults = UserDefaults.standard
                defaults.setValue(newPassword, forKey: newName)
                defaults.setValue(0, forKey: "HighScore")
            }
        }
        
    }
    
}
