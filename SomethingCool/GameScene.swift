//
//  GameScene.swift
//  SomethingCool
//
//  Created by HPro2 on 11/16/21.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private final var SPEED = 3
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func didMove(to view: SKView) {
        
        
        
        physicsWorld.contactDelegate = self
        
        // creates bouncy border
        let border = SKPhysicsBody(edgeLoopFrom: frame)
//        let topBorder = SKPhysicsBody(edgeFrom: CGPoint(x: 500, y: 500), to: CGPoint(x: 500, y: 700))
//        topBorder.friction = 500
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
//        drawPath(from: projectile.position, to: projectile.position)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "proj" && contact.bodyB.node?.name == "proj" {
            contact.bodyA.node?.physicsBody?.isDynamic = false
            contact.bodyB.node?.physicsBody?.isDynamic = false
            print ("test")
        }
    }
    
    
//    func touchDown(atPoint pos : CGPoint) {
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var ball = Ball(touches)
        addChild(ball)
        
                
    }
    
    func drawPath(from fromPoint: CGPoint, to toPoint: CGPoint) {
      // 1
        UIGraphicsBeginImageContext(view!.frame.size)
      guard let context = UIGraphicsGetCurrentContext() else {
        return
      }

        view?.draw(view!.layer, in: context)

      // 2
      context.move(to: fromPoint)
      context.addLine(to: toPoint)

      // 3
      context.setLineCap(.round)
      context.setBlendMode(.normal)
      context.setLineWidth(brushWidth)
      context.setStrokeColor(color.cgColor)

      // 4
      context.strokePath()

//       5
//      tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//      tempImageView.alpha = opacity
      UIGraphicsEndImageContext()




      // 6

//        let currentPoint = projectile.position
//      drawPath(from: lastPoint, to: currentPoint)
//
//      // 7
//      lastPoint = currentPoint
    }
    

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {


    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }


    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    
    
}


