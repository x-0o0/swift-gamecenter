@preconcurrency import GameKit
import SwiftUI

@MainActor
open class GameCenter: NSObject, ObservableObject {
    @Published public var isAuthenticated: Bool = GKLocalPlayer.local.isAuthenticated {
        didSet {
            self.setupAccessPoint()
        }
    }
    @Published public var myAchievements: [GKAchievement] = []
    
    open var rootViewController: UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return nil }
        return rootViewController
    }
    
    let accessPoint: GKAccessPoint
    
    public init(accessPoint: GKAccessPoint = GKAccessPoint.shared) {
        self.accessPoint = accessPoint
    }
    
    // MARK: - Game Center ViewController
    open func presentViewController(state: GKGameCenterViewControllerState, completion: (() -> Void)? = nil) {
        let viewController = GKGameCenterViewController(state: state)
        viewController.gameCenterDelegate = self
        self.presentGameCenterViewController(viewController, completion: completion)
    }
    
    func presentGameCenterViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        guard let rootViewController = self.rootViewController else {
            (viewController as? GKGameCenterViewController)?.gameCenterDelegate = nil
            return
        }
        rootViewController.present(viewController, animated: true, completion: completion)
    }
    
    // MARK: - Initalize
    open func initializeLocalPlayer(authenicationHandler: ((UIViewController?, (any Error)?) -> Void)? = nil) {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            authenicationHandler?(viewController, error)
            
            if let viewController {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
                rootViewController.present(viewController, animated: true)
            }
            
            if error != nil {
                // Player is not available
                // Disable Game Center in the game.
                return
            }
            
            // Player is available.
            // Check if there are any player restrictions before starting the game.
            
            if GKLocalPlayer.local.isUnderage {
                // Hide explicit game content.
            }
            
            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                // Disable multiplayer game features.
            }
            
            if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
                // Disable in game communication UI.
            }
            
            // Perform any other configurations as needed (for example, access point).
            if GKLocalPlayer.local.isAuthenticated {
                self.isAuthenticated = true
            }
        }
    }
    
    // MARK: - Access Point
    func setupAccessPoint() {
        self.accessPoint.location = .topTrailing
        self.accessPoint.showHighlights = true
    }
    
    open func showAccessPoint() {
        self.accessPoint.isActive = true
    }
    
    open func hideAccessPoint() {
        self.accessPoint.isActive = false
    }
    
    // MARK: - Achievement
    
    open func achieve(_ achievementInfo: any AchievementProtocol) {
        let achievement = GKAchievement(identifier: achievementInfo.id)
        achievement.showsCompletionBanner = true
        achievement.percentComplete = achievementInfo.percentageUnit
        Task {
            do {
                try await GKAchievement.report([achievement])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// (개발자 모드) 업적 초기화
    /// Author: Jager Yoo
    @_spi(Developer)
    public func resetAchievement() {
        guard GKLocalPlayer.local.isAuthenticated else { return }
        GKAchievement.resetAchievements { error in
            if let error = error {
                print("❌ Failed to reset achievements: \(error.localizedDescription)")
            } else {
                print("🔄 All achievements have been reset successfully!")
            }
        }
    }
    
    open func fetchMyAchievement() async {
        do {
            // load
            let achievements = try await GKAchievement.loadAchievements()
            self.myAchievements = achievements
            debugPrint(achievements)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension GameCenter: @preconcurrency GKGameCenterControllerDelegate {
    open func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}
