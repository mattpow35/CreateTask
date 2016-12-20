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
    
    var juggleBall = SKSpriteNode(imageNamed: "soccer ball")
 
    
    override func didMove(to view: SKView)
    {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        juggleBall.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10), at: CGPoint(x: 0, y:0))
    }
 
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered\\
        
        

        
    }
}
