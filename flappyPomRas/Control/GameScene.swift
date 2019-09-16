//
//  GameScene.swift
//  flappyPomRas
//
//  Created by Alyson Abril on 9/13/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var didGameStart = false
    var dead = false
    
    //Counter
    var score: Int = 0
    
    //Labels
    var scoreLabel = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    var tapToPlay = SKLabelNode()
    
    //Buttons
    var restartButton = SKSpriteNode()
    var puaseButton = SKSpriteNode()
    
    //Logo
    var logo = SKSpriteNode()
    
    //Pillar
    var xCodePillar = SKNode()
    var moveAndRemove = SKAction()
    
    //Avatar (Pomegranate / Raspberry)
    //Create Atlas
    var
    
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func didMove(to view: SKView) {
        
    }
}

extension GameScene {
    
}
