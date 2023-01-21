//
//  GameScene.swift
//  Pongish2022
//
//  Created by Christopher Walter on 1/21/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var paddle = SKSpriteNode()
    var ball = SKSpriteNode()
    
    override func didMove(to view: SKView)
    {
        
        physicsWorld.contactDelegate = self
        
        paddle = childNode(withName: "paddle") as! SKSpriteNode
        ball = childNode(withName: "ball") as! SKSpriteNode
        
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.contactTestBitMask = 2
        
        // makes the sides of our screen the boundaries
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = border
        
        
    }
    
    
    // when we tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // find location of touch (first touch only)
        let touch = touches.first!
        
        // figure out where touch is on screen
        let location = touch.location(in: self)
        
        // move paddle to location
        paddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        
        // make a face appear if we tap in the upper half of the screen
        if location.y > frame.height / 2 {
            createKristin(touchLocation: location)
        }
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // find location of touch (first touch only)
        let touch = touches.first!
        
        // figure out where touch is on screen
        let location = touch.location(in: self)
        
        // move paddle to location
        paddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        
        
    }
    
    // make people appear in a specific location
    func createKristin(touchLocation: CGPoint)
    {
        // create a spritenode, set the size and position
        let kristin = SKSpriteNode(imageNamed: "KristinMedium")
        kristin.size = CGSize(width: 75, height: 75)
        kristin.position = touchLocation
        
        // add to the view
        addChild(kristin)
        
        kristin.physicsBody = SKPhysicsBody(circleOfRadius: 37.5)
        kristin.physicsBody?.affectedByGravity = false
        kristin.physicsBody?.isDynamic = false
        
        // set the contact bit masks
        
        kristin.physicsBody?.categoryBitMask = 2
        kristin.physicsBody?.contactTestBitMask = 1
    }
    
    // "listen" for th contacts
    
    func didBegin(_ contact: SKPhysicsContact) {

        
        // is contact occuring between the ball and face
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2 {
            print("Ball hit face")
            contact.bodyB.node?.removeFromParent()
        }
        
        if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1
        {
            print("ball hit face")
            contact.bodyA.node?.removeFromParent()
        }
    }
}
