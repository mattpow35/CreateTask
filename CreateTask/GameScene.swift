//
//  GameScene.swift
//  CreateTask
//
//  Created by Powley, Matthew on 12/20/16.
//  Copyright © 2016 Powley, Matthew. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var juggleBall = SKSpriteNode()
    var jugglePaddle = SKSpriteNode()
    var background = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var score = Int()
    var highScoreLabel = SKLabelNode()
    var highScore = Int()
    var gravityNode = SKFieldNode()
    var startLabel = SKLabelNode()
    
    //category bit masks
    let juggleBallCategory : UInt32 = 0x1 << 0
    let BottomCategory : UInt32 = 0x1 << 1
    let borderCategory : UInt32 = 0x1 << 2
    let jugglePaddleCategory : UInt32 = 0x1 << 3
    
    
    
    override func didMove(to view: SKView)
    {
        
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        
        let bottomRectangle = CGRect(x: frame.origin.x , y: frame.origin.y , width: frame.size.width, height: 1)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRectangle)
        addChild(bottom)
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        
        juggleBall = self.childNode(withName: "juggleBall") as! SKSpriteNode
        jugglePaddle = self.childNode(withName: "jugglePaddle") as! SKSpriteNode
        background = self.childNode(withName: "soccerBackground-1") as! SKSpriteNode
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        score = 0
        scoreLabel.text = "Score: \(score)"
        highScoreLabel = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        highScore = 0
        highScoreLabel.text = "Best: \(highScore)"
        
        bottom.physicsBody!.categoryBitMask = BottomCategory
        juggleBall.physicsBody!.categoryBitMask = juggleBallCategory
        jugglePaddle.physicsBody!.categoryBitMask = jugglePaddleCategory
        border.categoryBitMask = borderCategory
        
        juggleBall.physicsBody!.contactTestBitMask = BottomCategory | jugglePaddleCategory
        
        startLabel = self.childNode(withName: "startLabel") as! SKLabelNode
        
        
    }
    
    func beginGame()
    {
      
        resetPaddle()
        startLabel.removeFromParent()
        gravityNode = SKFieldNode.linearGravityField(withVector: vector_float3(0,-1,0))
        gravityNode.strength = 0
        gravityNode.strength += 6
        addChild(gravityNode)
    }
    
    func resetPaddle()
    {
        jugglePaddle.position.x = 0
        jugglePaddle.position.y = -500
    }
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if (score == 0)
        {
          beginGame()
            for touch in touches
            {
                let location = touch.location(in: self)
                
                jugglePaddle.run(SKAction .moveTo(x: location.x, duration: 0.1))
            }
        }
        else
        {
            for touch in touches
            {
                let location = touch.location(in: self)
            
                jugglePaddle.run(SKAction .moveTo(x: location.x, duration: 0.1))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            jugglePaddle.run(SKAction .moveTo(x: location.x, duration: 0.1))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        
        
        // 1 
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        
        //2 
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //3
        if firstBody.categoryBitMask == juggleBallCategory && secondBody.categoryBitMask == BottomCategory
        {
            
            
            print("made contact with bottom")
        }
        
        if firstBody.categoryBitMask == juggleBallCategory && secondBody.categoryBitMask == jugglePaddleCategory
        {
            madeContactWithCleat()
            print("made contact")
        }
      
    }
    
    func madeContactWithCleat()
    {
        score += 1
        scoreLabel.text = "Score: \(score)"
        print("\(score)")
    }
 

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered\\
        
        if score >= highScore
        {
            highScore = score
            
            highScoreLabel.text = "Best: \(highScore)"
        }
        /*
            I would suggest starting the shoe back in the middle, but have a pause between when the game ends, and when it starts. Causing it to feel like a new game each time you lose.
            I agree with the above comment. Perhaps attempt to implement some sort of reset variable.
            use NSUser to store high score
         */
        
        if juggleBall.position.y <= jugglePaddle.position.y
        {
            gravityNode.strength = 0
            resetPaddle()
            score = 0
            scoreLabel.text = "Score: \(score)"
            juggleBall.position = CGPoint(x: 0, y: 400)
            juggleBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            addChild(startLabel)
        }
        
        
    }
}
