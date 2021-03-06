//
//  Ball.swift
//  SomethingCool
//
//  Created by HPro2 on 3/24/22.
//

import Foundation
import SpriteKit
import GameplayKit

// struct

// creates custom arithmetic functions for CGPoints specifically



class Ball: SKNode {
    
    init(_ touches: Set<UITouch>) {
        
        super.init()
        let num = Int.random(in: 1...6)
        var image: String
        switch num {
        case 1:
            image = "ballBlue"
            break
        case 2:
            image = "ballCyan"
            break
        case 3:
            image = "ballGreen"
            break
        case 4:
            image = "ballGrey"
            break
        case 5:
            image = "ballRed"
            break
        case 6:
            image = "ballYellow"
            break
        default:
            image = "ballPurple"
            
        }   
        let projectile = SKSpriteNode(imageNamed: image)
        // Chooses one of the touches to work with
        guard let touch = touches.first else {
          return
        }
        let touchLocation = touch.location(in: self)
        
        // Sets up initial location of ball
        
        projectile.name = "proj"
//        projectile.position = CGPoint(x: 0,y: -667)
//        projectile.position = touchLocation
        self.position = touchLocation
        // Determine offset of location to projectile
        let offset = touchLocation - projectile.position
        
        // Detects if you are shooting down or backwards and yeets that
        if offset.y < 0 { return }
        
        // gives all the properties to the ball
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2.0)
        projectile.physicsBody?.affectedByGravity = false;
        projectile.physicsBody!.contactTestBitMask = projectile.physicsBody!.collisionBitMask
        projectile.physicsBody!.restitution = 1
        projectile.physicsBody?.isDynamic = true
        projectile.zPosition = 1
        projectile.physicsBody!.linearDamping = 0
        projectile.physicsBody!.mass = 0.1
        
        print (touchLocation)
        addChild(projectile)
        
        // Makes vector for the ball to shoot on
        let vect = CGVector(dx: offset.x, dy: offset.y)
        
//        print (offset)
        
        // Creates the Force action
        let launch = SKAction.applyForce(vect, duration: 0.1)

        projectile.run(launch)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
