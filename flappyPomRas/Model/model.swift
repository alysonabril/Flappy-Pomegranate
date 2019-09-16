//
//  model.swift
//  flappyPomRas
//
//  Created by Alyson Abril on 9/13/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import Foundation

struct CollisionBitMask {
    static let avatarCategory:UInt32 = 0x1 << 0
    static let pillarCategory:UInt32 = 0x1 << 1
    static let staffCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
}

