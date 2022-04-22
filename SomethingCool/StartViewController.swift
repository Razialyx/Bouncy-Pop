//
//  StartViewController.swift
//  Bouncy Pop
//
//  Created by HPro2 on 4/21/22.
//

import Foundation
import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func startGamePressed(_ sender: Any) {
        var newName = userNameTextField.text
        var newPassword = passwordTextField.text
        Player player = new Player(name: newName, password: newPassword)
    }
    
}
