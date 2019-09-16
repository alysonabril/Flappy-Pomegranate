//
//  GameSceneExtension.swift
//  flappyPomRas
//
//  Created by Jack Wong on 9/16/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func createFruit() -> SKSpriteNode {

        let fruit = SKSpriteNode(texture: SKTextureAtlas(named: "PomRas").textureNamed("pomWings"))

        //Fruit
        fruit.size = CGSize(width: 100, height: 100)
        
        fruit.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        //Fruit Physics Body
        fruit.physicsBody = SKPhysicsBody(circleOfRadius: fruit.size.width / 2)
        
        
        //Linear Damping: This property is used to simulate fluid or air friction forces on the body. The property must be a value between 0.0 and 1.0. The default value is 0.1. If the value is 0.0, no linear damping is applied to the object.
        fruit.physicsBody?.linearDamping = 1.0
        
        //This is how we determine the bounciness of said fruit
        fruit.physicsBody?.restitution = 0
        
        fruit.physicsBody?.categoryBitMask = CollisionBitMask.avatarCategory
        fruit.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
        
        fruit.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.staffCategory | CollisionBitMask.groundCategory
     
        //Fruit is floating
        fruit.physicsBody?.affectedByGravity = false
        fruit.physicsBody?.isDynamic = true
        
        return fruit
    }
    
}
