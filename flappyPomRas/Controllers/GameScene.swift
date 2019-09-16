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
    var tapToPlayLabel = SKLabelNode()
    
    //Buttons
    var restartButton = SKSpriteNode()
    var pauseButton = SKSpriteNode()
    
    //Logo
    var logo = SKSpriteNode()
    
    //Pillar
    var xCodePillar = SKNode()
    var moveAndRemove = SKAction()
    
    //Avatar (Pomegranate / Raspberry)
    //Create Atlas
    let fruitAtlas = SKTextureAtlas(named: "PomRas")
    var fruitSprites = Array<Any>()
    var fruit = SKSpriteNode()
    var repeatActionFruit = SKAction()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if didGameStart == true{
            if dead == false{
                enumerateChildNodes(withName: "background") { (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 2 , y: bg.position.y)
                    
                    if bg.position.x <= -bg.size.width {
                        bg.position = CGPoint(x: bg.position.x + bg.size.width * 2, y: bg.position.y)
                    }
                    
                    
                }
            }
        }

    }
    
    override func didMove(to view: SKView) {
        createScene()
    }
    
    func createScene() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.avatarCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.avatarCategory
        
        //We don't want the screen to move !
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsWorld.contactDelegate = self
        
        
        //Create 2 instances of background and loop through them
        
        for i in 0..<2 {
            let background = SKSpriteNode(imageNamed: "bg")
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
        
        fruitSprites.append(fruitAtlas.textureNamed("pomWings"))
        fruitSprites.append(fruitAtlas.textureNamed("pomWingsUp"))
        
        self.fruit = createFruit()
        self.addChild(fruit)
        
        let fruitAnimation = SKAction.animate(with: self.fruitSprites as! [SKTexture], timePerFrame: 0.1)
        
        self.repeatActionFruit = SKAction.repeatForever(fruitAnimation)
        
        
        scoreLabel = createScoreLabel()
        self.addChild(scoreLabel)
        
        highScoreLabel = createHighscoreLabel()
        self.addChild(highScoreLabel)
        
        createLogo()
        
        tapToPlayLabel = createTaptoplayLabel()
        self.addChild(tapToPlayLabel)
        
    }
    
}

