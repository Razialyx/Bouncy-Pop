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
    var upArrow, downArrow: SKSpriteNode!
    var upBool, downBool: Bool!
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "barBackground")
        
        background.position = CGPoint(x: 360, y: 620)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        upBool = false
        downBool = false
        
        bar = SKSpriteNode(color: .blue, size: CGSize(width: 20, height: 160))
        bar.position = barPos
        bar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 160))
        bar.physicsBody!.isDynamic = false
        bar.name = "bar"
        addChild(bar)
        
        upArrow = SKSpriteNode(imageNamed: "arrow")
        upArrow.position = CGPoint(x: 550, y: 750)
        addChild(upArrow)
        
        downArrow = SKSpriteNode(imageNamed: "arrow")
        downArrow.position = CGPoint(x: 550, y: 550)
        downArrow.zRotation = Double.pi
        addChild(downArrow)
        
//        let joint = SKPhysicsJointPin.joint(
//            withBodyA: bar.physicsBody!, bodyB: (scene?.physicsBody)!, anchor: barPos)
//
//        scene!.physicsWorld.add(joint)
        
        
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
        if upArrow.contains(pos) {
            print ("test")
            bar.zRotation += 0.1
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            if tappedNodes.contains(upArrow) {
                upBool = true
            } else if tappedNodes.contains(downArrow){
                downBool = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            if tappedNodes.contains(upArrow) {
                upBool = false
            } else if tappedNodes.contains(downArrow){
                downBool = false
            }
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if upBool {
            bar.zRotation -= 0.02
        } else if downBool {
            bar.zRotation += 0.02
        }
    }
    
    
    
    
}



