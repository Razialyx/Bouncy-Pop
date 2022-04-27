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
    var instance : GameViewController!
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private final var SPEED = 3
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var barTime = false
    
    var shotBalls = [SKSpriteNode]()
    var madeBars = [SKSpriteNode]()
    var resetButton: SKSpriteNode!
    var hammerButton: SKSpriteNode!
    var barsLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var gameOverLabel: SKLabelNode!
    var continueButton: SKLabelNode!
    var cannon: SKSpriteNode!
    var labelBackground: SKSpriteNode!
    var scoreBackground: SKSpriteNode!
    var bars = 0
    var score = 0
    var badShots = 0 {
        didSet {
            
            if badShots != 0 {
                if badShots % 8 == 0 {
                    shotBalls.last?.removeFromParent()
                    addNewLayer(amount: 17, width: 40, y: CGFloat(1180 - badShots * 10))
                    
                } else if badShots % 4 == 0 {
                    shotBalls.last?.removeFromParent()
                    addNewLayer(amount: 16, width: 40, y: CGFloat(1180 - badShots * 10))
                }
            }
        }
    }
    var image: String = ""
    var pos: CGFloat = 2
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        
        background.position = CGPoint(x: 360, y: 620)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        randomizeBall()
        
        resetButton = SKSpriteNode(imageNamed: "Restart Button")
        resetButton.position = CGPoint(x: 60, y: 60)
        resetButton.zPosition = 2
        addChild(resetButton)
        
        hammerButton = SKSpriteNode(imageNamed: "hammer")
        hammerButton.position = CGPoint(x: 200, y: 60)
        hammerButton.zPosition = 2
        addChild(hammerButton)
        
        barsLabel = SKLabelNode(text: "Bars Available: 0")
        barsLabel.position = CGPoint(x: 570, y: 40)
        barsLabel.fontColor = .black
        barsLabel.fontName = "Avenir Next Bold Italic"
        addChild(barsLabel)
        
        labelBackground = SKSpriteNode(color: UIColor.red, size: CGSize(width: CGFloat(barsLabel.frame.size.width + 40), height:CGFloat(barsLabel.frame.size.height + 5)))
        labelBackground.position = CGPoint(x: CGFloat(570), y: CGFloat(50))
        addChild(labelBackground)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 570, y: 80)
        scoreLabel.fontColor = .blue
        scoreLabel.fontSize = 40
        scoreLabel.fontName = "Cochin Bold Italic"
        addChild(scoreLabel)
        
        scoreBackground = SKSpriteNode(color: UIColor.orange, size: CGSize(width: CGFloat(scoreLabel.frame.size.width + 100), height:CGFloat(scoreLabel.frame.size.height + 10)))
        scoreBackground.position = CGPoint(x: CGFloat(570), y: CGFloat(93))
        addChild(scoreBackground)
        
        cannon = SKSpriteNode(imageNamed: "cannon")
        cannon.position = CGPoint(x: 350, y: 70)
        cannon.zPosition = 2
        addChild(cannon)
        
        physicsWorld.contactDelegate = self
        
        setUp()
        
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
            }
            if contact.bodyA.node?.name == contact.bodyB.node?.name {
                if let pop = SKEmitterNode(fileNamed: "ballPop") {
                    pop.position = contact.bodyA.node!.position
                    pop.zPosition = 3
                    self.addChild(pop)
                    
                }
                chainReaction(ball: contact.bodyA.node!, color: (contact.bodyA.node?.name)!)
                
                
                
                bars += 1
                score += 1
                barsLabel.text = "Bars Available: \(bars)"
                scoreLabel.text = "Score: \(score)"
            } else {
                badShots += 1
            }
            
        }
        
        for ball in shotBalls {
            
            if ball.position.y < 200 && !ball.physicsBody!.isDynamic{
                
                print (ball)
                
                gameOverLabel = SKLabelNode(text: "Game Over")
                gameOverLabel.fontName = "Hoefler Text Black Italic"
                gameOverLabel.fontSize = 100
                gameOverLabel.fontColor = .purple
                gameOverLabel.position = CGPoint(x: 350, y: 700)
                addChild(gameOverLabel)
                
                
                
                continueButton = SKLabelNode(text: "Continue")
                continueButton.fontName = "Gill Sans Bold"
                continueButton.fontSize = 50
                continueButton.fontColor = .green
                continueButton.position = CGPoint(x: 350, y: 600)
                addChild(continueButton)
                
                
                for node in shotBalls {
                    node.removeFromParent()
                }
                for node in madeBars {
                    node.removeFromParent()
                }
                barTime = false
                bars = 0
                badShots = 0
                barsLabel.text = "Bars Available: 0"
                setUp()
                
                
                
            }
            
        }
        
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
            if tappedNodes.contains(resetButton) {
                
                for node in shotBalls {
                    node.removeFromParent()
                }
                for node in madeBars {
                    node.removeFromParent()
                }
                
                if gameOverLabel != nil && continueButton != nil {
                    
                    gameOverLabel.removeFromParent()
                    continueButton.removeFromParent()
                }
                
                barTime = false
                bars = 0
                badShots = 0
                barsLabel.text = "Bars Available: 0"
                setUp()
            } else if tappedNodes.contains(hammerButton) {
                
                barTime = !barTime
                
                if barTime {
                    hammerButton.texture = SKTexture(imageNamed: "hammerDown")
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let rotateBarController = storyboard.instantiateViewController(identifier: "RotateBarVC") as! RotateBarViewController
                    instance.present(rotateBarController, animated: true, completion: nil)
                    
                } else {
                    hammerButton.texture = SKTexture(imageNamed: "hammer")
                    
                }
                
            } else {
                if barTime {
                    hammerButton.texture = SKTexture(imageNamed: "hammerDown")
                    makeBar(touches)
                } else {
                    hammerButton.texture = SKTexture(imageNamed: "hammer")
                    makeBall(touches)
                }
            }
        }
        
    }
    
    func makeBall(_ touches: Set<UITouch>) {
        
        let projectile = SKSpriteNode(imageNamed: image)
        // Chooses one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        // Sets up initial location of ball
        
        projectile.name = image
        projectile.position = CGPoint(x: 360,y: 0) //-667
        //        projectile.position = touchLocation
        self.position = touchLocation
        // Determine offset of location to projectile
        let offset = touchLocation - projectile.position
        
        // Detects if you are shooting down or backwards and yeets that
        if offset.y < 0 { return }
        
        let angle = atan(offset.y / offset.x)
        cannon.zRotation = angle + CGFloat(0.5 * Double.pi)
        // if statement for x position, if greater than middle, yScale = -1
        if touch.location(in: self).x > 360 {
            cannon.yScale = -1
            cannon.zRotation = angle + CGFloat(0.5 * Double.pi)
        } else {
            cannon.yScale = 1
            cannon.zRotation = angle + CGFloat(0.5 * Double.pi)
        }
        
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
        
        
        
        let length = sqrt(vect.dx * vect.dx + vect.dy * vect.dy)
        let time = 100/length
        // Creates the Force action
        
        let launch = SKAction.applyForce(vect, duration: TimeInterval(time))
        
        
        projectile.run(launch)
        
        randomizeBall()
        
        let preview = SKSpriteNode(imageNamed: image)
        
        preview.position = CGPoint(x: 350, y: 50)
        preview.zPosition = pos
        addChild(preview)
        pos += 1
        
        
    }
    
    func randomizeBall() {
        let num = Int.random(in: 1...6)
        
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
    }
    
    func makeBar(_ touches: Set<UITouch>) {
        
        let width = 10
        let height = 80
        
        if (bars > 0) {
            
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
            madeBars.append(bar)
            addChild(bar)
            bars -= 1
            barsLabel.text = "Bars Available: \(bars)"
        } else {
            bars = 0
            barTime = false
        }
        
        
    }
    
    func addNewLayer(amount: Int, width: Int, y: CGFloat) {
        for i in 1...amount {
            createSetUpBall(x: CGFloat(i*width), y: y)
        }
    }
    
    func createSetUpBall(x: CGFloat, y: CGFloat) {
        
        let num = Int.random(in: 1...6)
        
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
        let ball = SKSpriteNode(imageNamed: image)
        // Chooses one of the touches to work with
        
        // Sets up initial location of ball
        
        ball.name = image
        ball.position = CGPoint(x: x,y: y)
        
        // gives all the properties to the ball
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2.0)
        
        ball.physicsBody?.affectedByGravity = false;
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        ball.physicsBody!.restitution = 0
        ball.physicsBody?.isDynamic = false
        ball.zPosition = 1
        ball.physicsBody!.linearDamping = 0
        ball.physicsBody!.mass = 0.1
        
        
        
        shotBalls.append(ball)
        addChild(ball)
        
        let preview = SKSpriteNode(imageNamed: image)
        
        preview.position = CGPoint(x: 350, y: 50)
        preview.zPosition = pos
        addChild(preview)
        pos += 1
        
    }
    
    func setUp() {
        
        let width = 40
        
        for i in 1...17 {
            createSetUpBall(x: CGFloat(i*width), y: 1300)
        }
        for i in 1...16 {
            createSetUpBall(x: CGFloat(i*width + 25), y: 1260)
        }
        for i in 1...17 {
            createSetUpBall(x: CGFloat(i*width), y: 1220)
        }
        for i in 1...16 {
            createSetUpBall(x: CGFloat(i*width + 25), y: 1180)
        }
        
    }
    
    
    
    func chainReaction(ball: SKNode, color: String) {
        
        let location = (ball.position)
        var balls = nodesNearPoint(container: self, point: location, maxDistance: 80)
        
        for node in balls {
            if node.name == color {
                node.removeFromParent()
            }
        }
        
    }
    
    func nodesNearPoint(container:SKNode, point:CGPoint, maxDistance:CGFloat) -> [SKNode] {
        var array = [SKNode]()
        for node in container.children {
            // Only test sprite nodes (optional)
            if node is SKSpriteNode {
                let dx = point.x - node.position.x
                let dy = point.y - node.position.y
                
                let distance = sqrt(dx*dx + dy*dy)
                if (distance <= maxDistance) {
                    array.append(node)
                }
            }
        }
        return array
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


/**
 
 todo list:
 
 sound effects for impacts
 add view for high score and current score
 music
 that slide up view or a dialog for angle control of the bar
 
 
 */
