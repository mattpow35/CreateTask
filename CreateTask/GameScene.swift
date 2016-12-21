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
    
    override func didMove(to view: SKView)
    {
        difficultyLevel = 9.8
        juggleBall = self.childNode(withName: "juggleBall") as! SKSpriteNode
        jugglePaddle = self.childNode(withName: "jugglePaddle") as! SKSpriteNode
        
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        let gravityField = vector_float3(0,-1,0)
        let gravityNode = SKFieldNode.linearGravityField(withVector: gravityField)
        
        gravityNode.strength = difficultyLevel
        
        addChild(gravityNode)
    
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
 

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered\\
        
//        if juggleBall.position.y <= jugglePaddle.position.y - 70
//        {
//            self.viewController?.perfromSequeWithIdentifier("EndScreen", sneder: self)
//        }
        
    }
}
