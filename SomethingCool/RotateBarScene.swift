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
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        
        background.position = CGPoint(x: 360, y: 620)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
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
        
        let width = 10
        let height = 80
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let bar = SKSpriteNode(color: .blue, size: CGSize(width: width, height: height))
        bar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        bar.physicsBody!.isDynamic = false
        bar.zRotation = CGFloat.random(in: 0...5)
        bar.position = touchLocation
        bar.name = "bar"
        addChild(bar)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    
    
}



