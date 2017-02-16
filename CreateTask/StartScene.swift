//
//  StartScene.swift
//  CreateTask
//
//  Created by Powley, Matthew on 2/16/17.
//  Copyright © 2017 Powley, Matthew. All rights reserved.
//
import GameplayKit
import SpriteKit

class StartScene : SKScene
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let gameSceneTemp = GameScene(fileNamed: "GameScene")
        self.scene?.view?.presentScene(gameSceneTemp!, transition: SKTransition.doorsOpenHorizontal(withDuration: 1))
    }
    
    
}
