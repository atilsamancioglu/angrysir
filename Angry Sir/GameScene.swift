//
//  GameScene.swift
//  Angry Sir
//
//  Created by Atil Samancioglu on 12/11/2017.
//  Copyright © 2017 Atil Samancioglu. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var originalPosition : CGPoint!
    var bird = SKSpriteNode()
    var box = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var hasGone = false
    var scoreLabel = SKLabelNode()
    var score = 0
    
    enum ColliderType : UInt32 {
        case Bird = 1
        case Box = 2
    }
    

    
    override func didMove(to view: SKView) {
        
        
        
        bird = childNode(withName: "bird") as! SKSpriteNode
        originalPosition = bird.position
        
       let birdTexture = SKTexture(imageNamed: "bird")
        
        physicsWorld.contactDelegate = self
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 8)
        
        bird.physicsBody!.isDynamic = true
        bird.physicsBody!.mass = 0.1
        bird.physicsBody!.affectedByGravity = false
        bird.physicsBody!.allowsRotation = true
    
        //bird.physicsBody!.linearDamping = 0.1
        //bird.physicsBody!.angularDamping = 0.1
        //bird.physicsBody!.restitution = 0.2
        //bird.physicsBody!.friction = 0.2
        //bird.physicsBody!.pinned = false
        
        bird.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        /*
        let boxTextre = SKTexture(imageNamed: "brick")
        var boxExample = SKSpriteNode()
        boxExample = SKSpriteNode(texture: boxTextre)
        boxExample.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(boxExample)
 */
        
        
        let boxTexture = SKTexture(imageNamed: "brick")
        
        let size = CGSize(width: boxTexture.size().width / 5, height: boxTexture.size().width / 5)

        box = childNode(withName: "box") as! SKSpriteNode
        
        box.physicsBody = SKPhysicsBody(rectangleOf: size)
        
        box.physicsBody!.isDynamic = true
        box.physicsBody!.affectedByGravity = true
        box.physicsBody!.allowsRotation = true
        
        
        box.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        
        box2.physicsBody!.isDynamic = true
        box2.physicsBody!.affectedByGravity = true
        box2.physicsBody!.allowsRotation = true
        
        
        box2.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        
        box3.physicsBody!.isDynamic = true
        box3.physicsBody!.affectedByGravity = true
        box3.physicsBody!.allowsRotation = true
        
        
        box3.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        
        box4.physicsBody!.isDynamic = true
        box4.physicsBody!.affectedByGravity = true
        box4.physicsBody!.allowsRotation = true
        
        
        box4.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        
        box5.physicsBody!.isDynamic = true
        box5.physicsBody!.affectedByGravity = true
        box5.physicsBody!.allowsRotation = true
        
       
        box5.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        scoreLabel.fontName = "Helvetica"
        
        scoreLabel.fontSize = 60
        
        scoreLabel.text = "0"
        
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        
        self.addChild(scoreLabel)
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue  {
           
            score = score + 1
            scoreLabel.text = String(score)
        
        print("contact")
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if hasGone == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchedNodes = nodes(at: touchLocation)
                
                if !touchedNodes.isEmpty {
                    for node in touchedNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
                
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if hasGone == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchedNodes = nodes(at: touchLocation)
                
                if !touchedNodes.isEmpty {
                    for node in touchedNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if hasGone == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchedNodes = nodes(at: touchLocation)
                
                if !touchedNodes.isEmpty {
                    for node in touchedNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                let dx = -(touchLocation.x - originalPosition.x)
                                let dy = -(touchLocation.y - originalPosition.y)
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.applyAngularImpulse(-0.01)
                                bird.physicsBody?.affectedByGravity = true
                                
                                hasGone = true
                                
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let birdPhysicsBody = bird.physicsBody {
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && hasGone {
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zRotation = 0
                bird.position = originalPosition
                score = 0
                scoreLabel.text = String(score)
                hasGone = false
                
                
            }
        }
        
        
        
    }
}
