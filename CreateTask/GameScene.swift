//
//  GameScene.swift
//  CreateTask
//
//  Created by Powley, Matthew on 12/20/16.
//  Copyright © 2016 Powley, Matthew. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var juggleBall = SKSpriteNode()
    var jugglePaddle = SKSpriteNode()
    var difficultyLevel = Float()
    var background = SKSpriteNode()
    var score = Int()
    var scoreLabel = SKLabelNode()
    
    //category bit masks
    let juggleBallCategory : UInt32 = 0x1 << 0
    let BottomCategory : UInt32 = 0x1 << 1
    let jugglePaddleCategory : UInt32 = 0x1 << 2
    let borderCategory : UInt32 = 0x1 << 2
    
    override func didMove(to view: SKView)
    {
        let bottomRectangle = CGRect(x: frame.origin.x , y: frame.origin.y , width: frame.size.width, height: 1)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRectangle)
        addChild(bottom)
        
        difficultyLevel = 9.8
        juggleBall = self.childNode(withName: "juggleBall") as! SKSpriteNode
        jugglePaddle = self.childNode(withName: "jugglePaddle") as! SKSpriteNode
        background = self.childNode(withName: "soccerBackground-1") as! SKSpriteNode
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        
        score = 0
        
        scoreLabel.text = "Score: \(score)"
        
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        let gravityField = vector_float3(0,-1,0)
        let gravityNode = SKFieldNode.linearGravityField(withVector: gravityField)
        
        gravityNode.strength = difficultyLevel
        
        addChild(gravityNode)
        
        addScore()
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            jugglePaddle.run(SKAction .moveTo(x: location.x, duration: 0.1))
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
    
    func addScore()
    {
        
    }

 

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered\\
        
//        if juggleBall.position.y <= jugglePaddle.position.y - 70
//        {
//           
//        }
        
        
        
    }
}
