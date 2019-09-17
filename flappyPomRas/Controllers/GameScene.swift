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
    var notDead = false
    
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
    var xCodePillarPair = SKNode()
    var moveAndRemove = SKAction()
    
    //Avatar (Pomegranate / Raspberry)
    //Create Atlas
    let fruitAtlas = SKTextureAtlas(named: "PomRas")
    var fruitSprites = Array<Any>()
    var fruit = SKSpriteNode()
    var repeatActionFruit = SKAction()
    
    
    
    //This is called when the user touches the screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if didGameStart == false{
            startGame()
        }
        
        fruit.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        fruit.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 160))
    }
    
    
    private func startGame(){
        didGameStart = true
        
        //Fruit avatar will now be able to fall
        fruit.physicsBody?.affectedByGravity = true
        
        //Pause button appears upon starting the game
        createPauseButton()
        
        //Logo shrinks and disappears
        logo.run(SKAction.scale(by: 0.5, duration: 0.3), completion: {
            self.logo.removeFromParent()
        })
        
        //Tap to play label disappears
        tapToPlayLabel.removeFromParent()
        
        //Fruit avatar will continue to be animated
        self.fruit.run(repeatActionFruit)
        
        
        //Spawn pillars
        let spawnXCodePair = SKAction.run {
            () in
            self.xCodePillarPair = self.createWalls()
            self.addChild(self.xCodePillarPair)
        }
        
        //Delay in seconds
        let delay = SKAction.wait(forDuration: 1.5)
        
        let SpawnDelay = SKAction.sequence([spawnXCodePair, delay])
        let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
        self.run(spawnDelayForever)

        let distance = CGFloat(self.frame.width + xCodePillarPair.frame.width)
        let movePillars = SKAction.moveBy(x: -distance - 50, y: 0, duration: TimeInterval(0.008 * distance))
        let removePillars = SKAction.removeFromParent()
        moveAndRemove = SKAction.sequence([movePillars, removePillars])
        
        
        //Velocity: The physics body’s velocity vector, measured in meters per second.
        fruit.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        //Applies an impulse to the center of gravity of a physics body.
        //            This method affects the body’s linear velocity without changing the body’s angular velocity.
        fruit.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 160))
    }
    
    
    //In an ideal situation 'update' is called 60 times per second
    override func update(_ currentTime: TimeInterval) {
        
        if didGameStart == true{
            if notDead == false{
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
//
//        fruitSprites.append(fruitAtlas.textureNamed("pomWings"))
//        fruitSprites.append(fruitAtlas.textureNamed("pomWingsUp"))
        
        fruitSprites.append(fruitAtlas.textureNamed("raspWings"))
           fruitSprites.append(fruitAtlas.textureNamed("raspWingsUp"))
        
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

