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
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(background)
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        var dialogMessage: UIAlertController
        
        if (defaults.string(forKey: userNameTextField.text!) == passwordTextField.text) {
            dialogMessage = UIAlertController(title: "Success!", message: "Login was successful.", preferredStyle: .alert)
        } else {
            dialogMessage = UIAlertController(title: "Error!", message: "Incorrect username or password!", preferredStyle: .alert)
             
             // Create OK button with action handler
             
        }
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
           
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let newName = userNameTextField.text {
            if let newPassword = passwordTextField.text {
                var player = Player(name: newName, password: newPassword, highScore: 0)
                
            }
        }
        defaults.set(passwordTextField.text, forKey: userNameTextField.text!)
        
        var dialogMessage = UIAlertController(title: "Success!", message: "New Account Created.", preferredStyle: .alert)
             
             // Create OK button with action handler
             
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
           
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        
        
    }
    
}
