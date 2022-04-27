//
//  RotateBarScene.swift
//  Bouncy Pop
//
//  Created by HPro2 on 4/27/22.
//

import SpriteKit
import GameplayKit
import UIKit

class RotateBarScene: SKScene, SKPhysicsContactDelegate {
    
    var instance : GameViewController!
    var bar: SKSpriteNode!
    let barPos = CGPoint(x: 360, y: 667)
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "barBackground")
        
        background.position = CGPoint(x: 360, y: 620)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        
        
        
        bar = SKSpriteNode(color: .blue, size: CGSize(width: 20, height: 160))
        bar.position = barPos
        bar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 160))
        bar.physicsBody!.isDynamic = false
        bar.name = "bar"
        addChild(bar)
        
        let joint = SKPhysicsJointPin.joint(
            withBodyA: bar.physicsBody!, bodyB: (scene?.physicsBody)!, anchor: barPos)

        scene!.physicsWorld.add(joint)
        
        physicsWorld.contactDelegate = self
        
        // creates bouncy border
        let border = SKPhysicsBody(edgeLoopFrom: frame)
        //        let topBorder = SKPhysicsBody(edgeFrom: CGPoint(x: 500, y: 500), to: CGPoint(x: 500, y: 700))
        //        topBorder.friction = 500
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            
        }
    }

    
    func makeBar(_ touches: Set<UITouch>) {
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        // Sets up initial location of ball
        
        
        
        
        
        // Determine offset of location to projectile
        let offset = touchLocation - barPos
        
        // Detects if you are shooting down or backwards and yeets that
        if offset.y < 0 { return }
        
        let angle = atan(offset.y / offset.x)
        bar.zRotation = angle + CGFloat(0.5 * Double.pi)
        // if statement for x position, if greater than middle, yScale = -1
        if touch.location(in: self).x > 360 {
            bar.yScale = -1
            bar.zRotation = angle + CGFloat(0.5 * Double.pi)
        } else {
            bar.yScale = 1
            bar.zRotation = angle + CGFloat(0.5 * Double.pi)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    
    
}



