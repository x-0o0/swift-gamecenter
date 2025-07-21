//
//  GameCenterPublicInterfaceTests.swift
//  swift-gamecenter
//
//  Created by 이재성 on 7/20/25.
//

import Testing
import GameKit
@testable import GameCenterModule

@Suite("Game Center Public Interface Tests")
@MainActor
struct GameCenterPublicInterfaceTests {
    let gameCenter = ChildGameCenter(accessPoint: GKAccessPoint())
    
    @Test func performExpectationTest() async throws {
        let expectedCount = 2
        await confirmation("Async", expectedCount: expectedCount) { confirm in
            confirm()
            try? await Task.sleep(for: .seconds(2))
            #expect(true)
            confirm()
        }
    }
    
    @Test(arguments: [
        EnglishAchievement.alphabet,
        EnglishAchievement.word,
        EnglishAchievement.sentence,
    ])
    func achieve(english: EnglishAchievement) async throws {
        gameCenter.onAchieving = { achievementInfo in
            #expect(achievementInfo.id == english.id)
        }
        gameCenter.achieve(english)
    }
    
    @Test func presentViewController() async throws {
        gameCenter.presentViewController(state: .achievements)
        let gameCenterViewController = try #require(gameCenter.rootViewController?.presentedViewController as? GKGameCenterViewController)
        #expect((gameCenterViewController.gameCenterDelegate as? GameCenter) == gameCenter)
        
    }
    
    @Test func showAccessPoint() async throws {
        // 1
        gameCenter.accessPoint.isActive = false
        
        gameCenter.onShowingAccessPoint = {
            // 3
            #expect(gameCenter.accessPoint.isActive)
        }
        
        // 2
        gameCenter.showAccessPoint()
    }
    
    @Test func hideAccessPoint() async throws {
        // 1
        gameCenter.accessPoint.isActive = false
        
        gameCenter.onHidingAccessPoint = {
            // 3
            #expect(!gameCenter.accessPoint.isActive)
        }
        
        // 2
        gameCenter.hideAccessPoint()
    }
}
