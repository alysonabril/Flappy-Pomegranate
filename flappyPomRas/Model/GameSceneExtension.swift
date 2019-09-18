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
        
//        let fruit = SKSpriteNode(texture: pomegrante)
        let fruit = SKSpriteNode()
                
        if isPom == true{
            fruit.texture = pomegrante
        }else{
            fruit.texture = raspberry
        }
        
        //Fruit
        fruit.size = CGSize(width: 100, height: 100)
        
        fruit.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        //Fruit Physics Body
        fruit.physicsBody = SKPhysicsBody(circleOfRadius: fruit.size.width / 2)
        
        
        //Linear Damping: This property is used to simulate fluid or air friction forces on the body. The property must be a value between 0.0 and 1.0. The default value is 0.1. If the value is 0.0, no linear damping is applied to the object.
        fruit.physicsBody?.linearDamping = 1.0
        
        //This is how we determine the bounciness of said fruit
        fruit.physicsBody?.restitution = 0.2
        
        fruit.physicsBody?.categoryBitMask = CollisionBitMask.avatarCategory
        fruit.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
        
        fruit.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.staffCategory | CollisionBitMask.groundCategory
        
        //Fruit is floating
        fruit.physicsBody?.affectedByGravity = false
        fruit.physicsBody?.isDynamic = true
        
        return fruit
    }
    
    func createRestartButton(){
        restartButton = SKSpriteNode(imageNamed: "restart")
        restartButton.size = CGSize(width: 100, height: 100)
        restartButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        restartButton.zPosition = 6
        restartButton.setScale(0)
        self.addChild(restartButton)
        restartButton.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    func createPauseButton() {
        pauseButton = SKSpriteNode(imageNamed: "pause")
        pauseButton.size = CGSize(width: 65, height: 65)
        pauseButton.position = CGPoint(x: self.frame.width - 40 , y: 45)

        pauseButton.zPosition = 6
        
        self.addChild(pauseButton)
    }
    
    func createSwitchFruitButton(){
        
        if isPom == true{
            switchFruitButton = SKSpriteNode(imageNamed: "raspWings")
        }else{
            switchFruitButton = SKSpriteNode(imageNamed: "pomWings")
        }
        switchFruitButton.size = CGSize(width: 100, height: 100)
        switchFruitButton.position = CGPoint(x: 30, y: 30)
        
        switchFruitButton.zPosition = 6
        self.addChild(switchFruitButton)

    }
    
    
    func createScoreLabel() -> SKLabelNode{
        let scoreLabel = SKLabelNode()
        scoreLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 3.0)
        scoreLabel.zPosition = 5
        scoreLabel.text = "\(score)"
        scoreLabel.text = "0"
        scoreLabel.fontName = "Noteworthy-Bold"
        scoreLabel.fontColor = SKColor.init(red: 252/255, green: 5/255, blue: 129/255, alpha: 1)
        
        
        return scoreLabel
    }
    
    
    func createHighscoreLabel() -> SKLabelNode {
        let highscoreLbl = SKLabelNode()
        highscoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 62)
        if let highestScore = UserDefaults.standard.object(forKey: "highestScore"){
            highscoreLbl.text = "High Score: \(highestScore)"
        } else {
            highscoreLbl.text = "High Score: 0"
        }
        highscoreLbl.zPosition = 5
        highscoreLbl.fontSize = 23
        highscoreLbl.fontName = "Noteworthy-Bold"
        return highscoreLbl
    }
    
//    func createUserPromptLabel() -> SKLabelNode{
//        let userChoiceLabel = SKLabelNode()
//        userChoiceLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 200)
//
//        userChoiceLabel.text = "Choose your character"
//        userChoiceLabel.zPosition = 5
//        userChoiceLabel.fontSize = 25
//        userChoiceLabel.fontName = "Noteworthy-Bold"
//
//        return userChoiceLabel
//    }
    
    
    func createLogo() {
        logo = SKSpriteNode()
        logo = SKSpriteNode(imageNamed: "LaunchScreenLogo")
        logo.size = CGSize(width: 272, height: 65)
        logo.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 150)
        logo.setScale(0.5)
        self.addChild(logo)
        logo.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    //6
    func createTaptoplayLabel() -> SKLabelNode {
        let taptoplayLbl = SKLabelNode()
        taptoplayLbl.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 100)
        taptoplayLbl.text = "Tap anywhere to play"
        taptoplayLbl.fontName = "Noteworthy-Bold"
        taptoplayLbl.fontColor = UIColor.black
        taptoplayLbl.zPosition = 5
        taptoplayLbl.fontSize = 20
        return taptoplayLbl
    }
    
    func createWalls() -> SKNode  {
       
        //Staff Bitmoji
        //David is used as a placeholder, rest of the staff will be added later
        
        let faces = ["David","David2","David3","David4", "Iram", "Iram3", "Ish", "Ish2", "Oli", "Oli2"]
        
        let randomFace = faces.randomElement()
        
        let staffBitmoji = SKSpriteNode(imageNamed: randomFace!)
        
        staffBitmoji.size = CGSize(width: 100, height: 100)
        staffBitmoji.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
        
        staffBitmoji.physicsBody = SKPhysicsBody(circleOfRadius: staffBitmoji.size.width / 2)
        
        staffBitmoji.physicsBody?.affectedByGravity = false
        staffBitmoji.physicsBody?.isDynamic = false
        staffBitmoji.physicsBody?.categoryBitMask = CollisionBitMask.staffCategory
        staffBitmoji.physicsBody?.collisionBitMask = 0
        staffBitmoji.physicsBody?.contactTestBitMask = CollisionBitMask.avatarCategory
//        staffBitmoji.color = SKColor.blue
        
        //Pair of xcode pillars
        xCodePillarPair = SKNode()
        xCodePillarPair.name = "xCodePillarPair"
        
//        let pillarArr = ["globalError","raspberryError","bracketError","bracketError2","expectedError","placeholderError", "redecError", "returnError", "typeError"]
//
        
        
//        let topPillar = SKSpriteNode(imageNamed: pillarArr.randomElement()!)
//        let bottomPillar = SKSpriteNode(imageNamed: pillarArr.randomElement()!)
    
        let topPillar = SKSpriteNode(imageNamed:"globalError")
               let bottomPillar = SKSpriteNode(imageNamed: "typeError")
        
        
        topPillar.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 420)
        bottomPillar.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 420)
        
        topPillar.setScale(0.6)
        bottomPillar.setScale(0.6)
        
        //Top Pillar
        topPillar.physicsBody = SKPhysicsBody(rectangleOf: topPillar.size)
        
        topPillar.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        topPillar.physicsBody?.collisionBitMask = CollisionBitMask.avatarCategory
        topPillar.physicsBody?.contactTestBitMask = CollisionBitMask.avatarCategory
        topPillar.physicsBody?.isDynamic = false
        topPillar.physicsBody?.affectedByGravity = false
        
        //Bottom Pillar
        bottomPillar.physicsBody = SKPhysicsBody(rectangleOf: bottomPillar.size)
        
        bottomPillar.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        bottomPillar.physicsBody?.collisionBitMask = CollisionBitMask.avatarCategory
        bottomPillar.physicsBody?.contactTestBitMask = CollisionBitMask.avatarCategory
        bottomPillar.physicsBody?.isDynamic = false
        bottomPillar.physicsBody?.affectedByGravity = false
        
        topPillar.zRotation = CGFloat.pi
        
        xCodePillarPair.addChild(topPillar)
        xCodePillarPair.addChild(bottomPillar)
        
        xCodePillarPair.zPosition = 1
        
        let randomPosition = random(min: -200, max: 200)
        xCodePillarPair.position.y = xCodePillarPair.position.y +  randomPosition
        
        xCodePillarPair.addChild(staffBitmoji)
        
        xCodePillarPair.run(moveAndRemove)
        
        return xCodePillarPair
    }
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
}
