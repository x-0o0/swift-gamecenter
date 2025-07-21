//
//  GameCenterSPITests.swift
//  swift-gamecenter
//
//  Created by 이재성 on 7/22/25.
//

import Testing
import GameKit
@_spi(Developer) import GameCenterModule

@Suite("Game Center SPI Tests")
@MainActor
struct GameCenterSPITests {
    let gameCenter = ChildGameCenter(accessPoint: GKAccessPoint())
    
    @Test func resetAchievement() {
        gameCenter.resetAchievement()
        #expect(true)
    }
}
