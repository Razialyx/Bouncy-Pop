//
//  Player.swift
//  Bouncy Pop
//
//  Created by HPro2 on 4/21/22.
//

import Foundation

class Player {
    var name: String
    var password: String
    var highScore: Int
    
    init(name: String, password: String, highScore: Int) {
        self.name = name
        self.password = password
        self.highScore = highScore
    }
 
}
