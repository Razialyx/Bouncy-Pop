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
    
    
    @IBAction func startGamePressed(_ sender: Any) {
        
        if (defaults.string(forKey: userNameTextField.text!) == passwordTextField.text) {
            
        } else {
            var dialogMessage = UIAlertController(title: "Error!", message: "Incorrect username or password!", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)
             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
        }
        
        if let newName = userNameTextField.text {
            if let newPassword = passwordTextField.text {
                var player = Player(name: newName, password: newPassword)
            }
        }
    }
    
}
