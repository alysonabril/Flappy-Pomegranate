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
        pauseButton.size = CGSize(width: 50, height: 50)
        pauseButton.position = CGPoint(x: self.frame.width - 30 , y: 30)
        pauseButton.zPosition = 6
        
        self.addChild(pauseButton)
        
    }

    func createScoreLabel() -> SKLabelNode{
        let scoreLabel = SKLabelNode()
        scoreLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.6)
        scoreLabel.zPosition = 5
        scoreLabel.text = "\(score)"
        scoreLabel.text = "HelveticaNeue-Bold"
        
       let scoreBg = SKShapeNode()
       scoreBg.position = CGPoint(x: 0, y: 0)
       scoreBg.path = CGPath(roundedRect: CGRect(x: CGFloat(-50), y: CGFloat(-30), width: CGFloat(100), height: CGFloat(100)), cornerWidth: 50, cornerHeight: 50, transform: nil)
       let scoreBgColor = UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(0.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: CGFloat(0.2))
       scoreBg.strokeColor = UIColor.clear
       scoreBg.fillColor = scoreBgColor
       scoreBg.zPosition = -1
       scoreLabel.addChild(scoreBg)
       return scoreLabel
    }

    func createHighscoreLabel() -> SKLabelNode {
        let highscoreLbl = SKLabelNode()
        highscoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 22)
        if let highestScore = UserDefaults.standard.object(forKey: "highestScore"){
            highscoreLbl.text = "Highest Score: \(highestScore)"
        } else {
            highscoreLbl.text = "Highest Score: 0"
        }
        highscoreLbl.zPosition = 5
        highscoreLbl.fontSize = 15
        highscoreLbl.fontName = "Helvetica-Bold"
        return highscoreLbl
    }
    //5
    func createLogo() {
        logo = SKSpriteNode()
        logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: 272, height: 65)
        logo.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 100)
        logo.setScale(0.5)
        self.addChild(logo)
        logo.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    //6
    func createTaptoplayLabel() -> SKLabelNode {
        let taptoplayLbl = SKLabelNode()
        taptoplayLbl.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 100)
        taptoplayLbl.text = "Tap anywhere to play"
        taptoplayLbl.fontColor = UIColor(red: 63/255, green: 79/255, blue: 145/255, alpha: 1.0)
        taptoplayLbl.zPosition = 5
        taptoplayLbl.fontSize = 20
        taptoplayLbl.fontName = "HelveticaNeue"
        return taptoplayLbl
    }
    
}
