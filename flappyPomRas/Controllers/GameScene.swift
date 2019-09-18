//
//  GameScene.swift
//  flappyPomRas
//
//  Created by Alyson Abril on 9/13/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene{
    
    var didGameStart = false
    var notDead = false
    var isPom = true
    
    //Counter
    var score: Int = 0
    
    //Labels
    var scoreLabel = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    var tapToPlayLabel = SKLabelNode()
    var userChoiceLabel = SKLabelNode()
    
    //Buttons
    var restartButton = SKSpriteNode()
    var pauseButton = SKSpriteNode()
    var switchFruitButton = SKSpriteNode()
    
    
    //Logo
    var logo = SKSpriteNode()
    
    //Pillar
    var xCodePillarPair = SKNode()
    var moveAndRemove = SKAction()
    
    //Avatar (Pomegranate / Raspberry)
    //Create Atlas
    let fruitAtlas = SKTextureAtlas(named: "PomRas")
    var pomSprites = Array<Any>()
    var rasSprites = Array<Any>()
    var fruit = SKSpriteNode()
    var repeatActionPom = SKAction()
    var repeatActionRas = SKAction()
    
    
    //background Music
    var bgMusic = SKAudioNode()
    
    //Fruit Tecture
    let pomegrante = SKTextureAtlas(named: "PomRas").textureNamed("pomWings")
    let raspberry = SKTextureAtlas(named: "PomRas").textureNamed("raspWings")
    
    
    //randomsound
    static let soundArr = ["cool.mp3", "great.mp3", "awesome.mp3","neat.mp3", "whoa.mp3"]
    static var randomSoundName = soundArr.randomElement()!
    
    var playSound = SKAction.playSoundFileNamed(GameScene.randomSoundName, waitForCompletion: false)
    
    
    
    
    //This is called when the user touches the screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        //        if didGameStart == false{
        //
        //            //Logo shrinks and disappears
        //            logo.run(SKAction.scale(by: 0.5, duration: 0.2), completion: {
        //                self.logo.removeFromParent()
        //            })
        //
        //            //Tap to play label disappears
        //            tapToPlayLabel.removeFromParent()
        //
        ////            fruit.isHidden = true
        //
        ////            startGame()
        //        }
        
        
        //        //Fruit avatar will continue to be animated
        //        if isPom == true{
        //            self.fruit.run(repeatActionPom)
        //        }else{
        //            self.fruit.run(repeatActionRas)
        //        }
        
        //        enablePlayerMovement()
        
        for touch in touches{
            
            //Touch coordinates
            let location = touch.location(in: self)
            
            if switchFruitButton.contains(location){
                
                print("switch button pressed")
                
                if isPom == false{
                    switchFruitButton.texture = SKTexture(imageNamed: "pomWings")
                    fruit.texture = SKTextureAtlas(named: "PomRas").textureNamed("raspWings")
                    isPom = true
                }else{
                    switchFruitButton.texture = SKTexture(imageNamed: "raspWings")
                    fruit.texture = SKTextureAtlas(named: "PomRas").textureNamed("pomWings")
                    
                    isPom = false
                }
                return
            }
            
            
            //If user touches where the restart button is located, only appears if the game is over
            if notDead == true{
                if restartButton.contains(location){
                    if UserDefaults.standard.object(forKey: "highestScore") != nil {
                        let hscore = UserDefaults.standard.integer(forKey: "highestScore")
                        if hscore < Int(scoreLabel.text!)!{
                            UserDefaults.standard.set(scoreLabel.text, forKey: "highestScore")
                        }
                    } else {
                        UserDefaults.standard.set(0, forKey: "highestScore")
                    }
                    restartScene()
                    return
                }
                
            } else {
                //If the user touches where the pause button is located at
                if pauseButton.contains(location){
                    if self.isPaused == false{
                        self.isPaused = true
                        pauseButton.texture = SKTexture(imageNamed: "play")
                    } else {
                        self.isPaused = false
                        pauseButton.texture = SKTexture(imageNamed: "pause")
                    }
                }
            }
        }
        
        switch didGameStart {
            
        case false:
            
            //Logo shrinks and disappears
            logo.run(SKAction.scale(by: 0.5, duration: 0.2), completion: {
                self.logo.removeFromParent()
            })
            
            //Tap to play label disappears
            tapToPlayLabel.removeFromParent()
            
            //            fruit.isHidden = true
            
            switchFruitButton.removeFromParent()
            
            didGameStart = true
            
            startGame()
            enablePlayerMovement()
            
            
        case true:
            
            if isPom == false{
                self.fruit.run(repeatActionPom)

            }else{
                self.fruit.run(repeatActionRas)

            }
            
            
            enablePlayerMovement()
            
        }
        
        
    }
    
    private func enablePlayerMovement(){
        fruit.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        fruit.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 160))
    }
    
    
    private func startGame(){
        
        switchFruitButton.isHidden = true
        
        didGameStart = true
        
        
        //Fruit avatar will now be able to fall
        fruit.physicsBody?.affectedByGravity = true
        
        //Pause button appears upon starting the game
        createPauseButton()
        
        //Switch Fruit Button appears
        //        createChangeFruitButton()
        //
        //
        //        //Fruit avatar will continue to be animated
        //        self.fruit.run(repeatActionPom)
        
        
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
        
        //Fruit can move now
        enablePlayerMovement()
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
        
        pomSprites.append(fruitAtlas.textureNamed("pomWings"))
        pomSprites.append(fruitAtlas.textureNamed("pomWingsUp"))
        
        rasSprites.append(fruitAtlas.textureNamed("raspWings"))
        rasSprites.append(fruitAtlas.textureNamed("raspWingsUp"))
        
        self.fruit = createFruit()
        self.addChild(fruit)
        
        let pomAnimation = SKAction.animate(with: self.pomSprites as! [SKTexture], timePerFrame: 0.1)
        
        let rasAnimation = SKAction.animate(with: self.rasSprites as! [SKTexture], timePerFrame: 0.1)
        
        self.repeatActionPom = SKAction.repeatForever(pomAnimation)
        
        self.repeatActionRas = SKAction.repeatForever(rasAnimation)
        
        scoreLabel = createScoreLabel()
        self.addChild(scoreLabel)
        
        highScoreLabel = createHighscoreLabel()
        self.addChild(highScoreLabel)
        
        createLogo()
        
        tapToPlayLabel = createTaptoplayLabel()
        self.addChild(tapToPlayLabel)
        
        bgMusic = SKAudioNode(fileNamed: "gypsy.mp3" )
        self.addChild(bgMusic)
        
        createSwitchFruitButton()
        
    }
    
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        notDead = false
        didGameStart = false
        score = 0
        createScene()
    }
    
}

extension GameScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        
        
        //Game Over Scenario
        if bodyA.categoryBitMask == CollisionBitMask.avatarCategory && bodyB.categoryBitMask == CollisionBitMask.pillarCategory || bodyA.categoryBitMask == CollisionBitMask.pillarCategory && bodyB.categoryBitMask == CollisionBitMask.avatarCategory ||
            bodyA.categoryBitMask == CollisionBitMask.avatarCategory &&
            bodyB.categoryBitMask == CollisionBitMask.groundCategory ||
            bodyA.categoryBitMask == CollisionBitMask.groundCategory &&
            bodyB.categoryBitMask == CollisionBitMask.avatarCategory{
            
            //Stop everything
            enumerateChildNodes(withName: "xCodePillarPair", using: ({
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            }))
            
            if notDead == false{
                
                self.bgMusic.removeFromParent()
                run(SKAction.playSoundFileNamed("splat.mp3", waitForCompletion: true))
                //Game Over
                notDead = true
                
                //Remove Pause Button
                pauseButton.removeFromParent()
                
                //Show Restart Button
                createRestartButton()
                
                //Stop all actions (e.g. fruit animations)
                fruit.removeAllActions()
                

            }
            
            
        }else if bodyA.categoryBitMask == CollisionBitMask.avatarCategory && bodyB.categoryBitMask == CollisionBitMask.staffCategory{
            //plays random Davidism
            GameScene.randomSoundName = GameScene.soundArr.randomElement()!
            playSound = SKAction.playSoundFileNamed(GameScene.randomSoundName, waitForCompletion: false)
            run(playSound)
            
            //Update Score Counter
            
            
            score += 1
            scoreLabel.text = "\(score)"
            
            //Take out bitmoji
            
            bodyB.node?.removeFromParent()
            
            
        }else if bodyA.categoryBitMask == CollisionBitMask.staffCategory && bodyB.categoryBitMask == CollisionBitMask.avatarCategory{
            //plays random Davidism
            GameScene.randomSoundName = GameScene.soundArr.randomElement()!
            playSound = SKAction.playSoundFileNamed(GameScene.randomSoundName, waitForCompletion: false)
            
            run(playSound)
            //Update Score Counter
            score += 1
            scoreLabel.text = "\(score)"
            
            //Take out bitmoji
            
            bodyA.node?.removeFromParent()
            
        }
    }
    
}

