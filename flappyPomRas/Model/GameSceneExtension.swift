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
    
    func createAvatar() -> SKSpriteNode {

        let avatar = SKSpriteNode(texture: SKTextureAtlas(named: "PomRas").textureNamed("pomWings"))

        
        
        
        return avatar
    }
    
}
