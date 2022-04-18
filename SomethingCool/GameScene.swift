//
//  GameScene.swift
//  SomethingCool
//
//  Created by HPro2 on 11/16/21.
//

import SpriteKit
import GameplayKit
import UIKit

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

// function to square root

#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
}
#endif

// gets the length between two points using Pythagorean theorem

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private final var SPEED = 3
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var boxTime = false
    
    var shotBalls = [SKSpriteNode]()
    var resetButton: SKSpriteNode!
    var hammerButton: SKSpriteNode!
    var boxesLabel: SKLabelNode!
    var cannon: SKSpriteNode!
    var boxes = 0
    
    override func didMove(to view: SKView) {
        
        resetButton = SKSpriteNode(imageNamed: "Restart Button")
        resetButton.position = CGPoint(x: 60, y: 60)
        resetButton.zPosition = 2
        addChild(resetButton)
        
        hammerButton = SKSpriteNode(imageNamed: "hammer")
        hammerButton.position = CGPoint(x: 630, y: 130)
        hammerButton.zPosition = 2
        addChild(hammerButton)
        
        boxesLabel = SKLabelNode(text: "Bars Remaining: 0")
        boxesLabel.position = CGPoint(x: 570, y: 40)
        addChild(boxesLabel)
        
        cannon = SKSpriteNode(imageNamed: "cannon")
        cannon.position = CGPoint(x: 350, y: 70)
        cannon.zPosition = 2
        addChild(cannon)
        
        
        
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
        if contact.bodyA.node! is SKSpriteNode {
            if shotBalls.contains(contact.bodyA.node as! SKSpriteNode) && shotBalls.contains(contact.bodyB.node! as! SKSpriteNode) {
                contact.bodyA.node?.physicsBody?.isDynamic = false
                contact.bodyB.node?.physicsBody?.isDynamic = false
                print ("test")
            }
            if contact.bodyA.node?.name == contact.bodyB.node?.name {
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                boxes += 1
                boxesLabel.text = "Bars Remaining: \(boxes)"
            }
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

        print(boxTime)
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            if tappedNodes.contains(resetButton) {
                boxTime = false
                for node in shotBalls {
                    node.removeFromParent()
                }
            }
            if tappedNodes.contains(hammerButton) {
                
                boxTime = !boxTime
            } else {
                if boxTime {
                    makeBox(touches)
                } else {
                    makeBall(touches)
                }
            }
        }
        
    }
    
    func makeBall(_ touches: Set<UITouch>) {
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
        
        projectile.name = image
        projectile.position = CGPoint(x: 360,y: 0) //-667
        print(projectile.texture)
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
        
        shotBalls.append(projectile)
        addChild(projectile)
        
        // Makes vector for the ball to shoot on
        let vect = CGVector(dx: offset.x, dy: offset.y)
        
        //        print (offset)
        
        let length = sqrt(vect.dx * vect.dx + vect.dy * vect.dy)
        let time = 70/length
        // Creates the Force action
        
        let launch = SKAction.applyForce(vect, duration: TimeInterval(time))
        
        
        projectile.run(launch)
    }
    
    func makeBox(_ touches: Set<UITouch>) {
        
        boxes -= 1
        boxesLabel.text = "Bars Remaining: \(boxes)"
        
        if (boxes > 0) {
            
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let box = SKSpriteNode(color: .blue, size: CGSize(width: 20, height: 70))
        box.physicsBody = SKPhysicsBody(rectangleOf: size)
        box.physicsBody!.isDynamic = false
        box.zRotation = CGFloat.random(in: 0...5)
        box.position = touchLocation
        box.name = "box"
        addChild(box)
        } else {
            boxes = 0
            boxTime = false
        }
    }
    
    //    func setUp() {
    //        let num = Int.random(in: 1...6)
    //        var image: String
    //        switch num {
    //        case 1:
    //            image = "ballBlue"
    //            break
    //        case 2:
    //            image = "ballCyan"
    //            break
    //        case 3:
    //            image = "ballGreen"
    //            break
    //        case 4:
    //            image = "ballGrey"
    //            break
    //        case 5:
    //            image = "ballRed"
    //            break
    //        case 6:
    //            image = "ballYellow"
    //            break
    //        default:
    //            image = "ballPurple"
    //
    //        }
    //        let projectile = SKSpriteNode(imageNamed: image)
    //        // Chooses one of the touches to work with
    //
    //
    //        // Sets up initial location of ball
    //
    //        projectile.name = "image"
    //        projectile.position = CGPoint(x: 360,y: 0) //-667
    ////        projectile.position = touchLocation
    //
    //
    //
    //
    //        // gives all the properties to the ball
    //
    //        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2.0)
    //        projectile.physicsBody?.affectedByGravity = false;
    //        projectile.physicsBody!.contactTestBitMask = projectile.physicsBody!.collisionBitMask
    //        projectile.physicsBody!.restitution = 1
    //        projectile.physicsBody?.isDynamic = true
    //        projectile.zPosition = 1
    //        projectile.physicsBody!.linearDamping = 0
    //        projectile.physicsBody!.mass = 0.1
    //
    //        shotBalls.append(projectile)
    //        addChild(projectile)
    //
    //        // Makes vector for the ball to shoot on
    //        let vect = CGVector(dx: offset.x, dy: offset.y)
    //
    ////        print (offset)
    //
    //        let length = sqrt(vect.dx * vect.dx + vect.dy * vect.dy)
    //        let time = 70/length
    //        // Creates the Force action
    //
    //        let launch = SKAction.applyForce(vect, duration: TimeInterval(time))
    //
    //
    //        projectile.run(launch)
    //    }
    
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


