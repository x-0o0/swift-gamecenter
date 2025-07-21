//
//  ChildGameCenter.swift
//  swift-gamecenter
//
//  Created by 이재성 on 7/20/25.
//

import GameKit
import GameCenterModule

class ChildGameCenter: GameCenter {
    
    // MARK: Asertion
    
    var onPresentingViewController: ((_ state: GKGameCenterViewControllerState) -> Void)? = nil
    var onPresentingGameCenterViewController: ((_ viewController: UIViewController) -> Void)? = nil
    var onInitializingLocalPlayer: ((_ authenicationHandler: ((UIViewController?, (any Error)?) -> Void)?) -> Void)? = nil
    var onShowingAccessPoint: (() -> Void)? = nil
    var onHidingAccessPoint: (() -> Void)? = nil
    var onAchieving: ((_ achievementInfo: any AchievementProtocol) -> Void)? = nil
    var onFetchingMyAchievement: (() -> Void)? = nil
    var onEventGameCenterViewControllerDidFinish: ((_ gameCenterViewController: GKGameCenterViewController) -> Void)? = nil
    
    private var allAchievements: [GKAchievement]
    
    // MARK: Override
    
    override var rootViewController: UIViewController? { fixedRootViewController }
    let fixedRootViewController = RootViewController()
    
    override init(accessPoint: GKAccessPoint) {
        self.allAchievements = EnglishAchievement.allCases
            .compactMap { GKAchievement(identifier: $0.id) }
        
        super.init(accessPoint: accessPoint)
    }
    
    override func presentViewController(state: GKGameCenterViewControllerState, completion: (() -> Void)? = nil) {
        super.presentViewController(state: state, completion: completion)
        self.onPresentingViewController?(state)
    }
    
    override func initializeLocalPlayer(authenicationHandler: ((UIViewController?, (any Error)?) -> Void)? = nil) {
        self.onInitializingLocalPlayer?(authenicationHandler)
    }
    
    override func showAccessPoint() {
        super.showAccessPoint()
        self.onShowingAccessPoint?()
    }
    
    override func hideAccessPoint() {
        super.hideAccessPoint()
        self.onHidingAccessPoint?()
    }
    
    override func achieve(_ achievementInfo: any AchievementProtocol) {
        self.onAchieving?(achievementInfo)
    }
    
    override func fetchMyAchievement() async {
        self.onFetchingMyAchievement?()
    }
    
    override func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        self.onEventGameCenterViewControllerDidFinish?(gameCenterViewController)
    }
}
