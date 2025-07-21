# Game Center

Swift6+
iOS17+

## How to use

### Initialize local user

```swift
struct MyView: View {
  @StateObject private variable gameCenter = GameCenter()

  var body: some View {
    Text(gameCenter.isAuthenticated ? "Authenticated" : "Not Authenticated")
      .onAppear { gameCenter.initializeLocalPlayer() }
}
```

> **INFO:**
>
> Once it was initialized successfully, the GKAccessPoint is going to be set up synchronously.

### Present Game Center View Controller

```swift
gameCenter.presentViewController(state: .achievements)
```

### Show / Hide Game Center Access Point

```swift
gameCenter.showAccessPoint()

gameCenter.hideAccessPoint()
```

### Achievement

#### Local user's achievement histories
```swift
await gameCenter.fetchMyAchievement()
// then, access 'gameCenter.myAchievements'
```

#### Achieve
```swift
import GameCenterModule

enum EnglishAchievement: AchievementProtocol, CaseIterable {
    case alphabet
    case word
    case sentence
    
    var id: String {
        // Should be same as you registered on AppStore Connect
    }
    
    var percentageUnit: Double {
        // Used for complete percentage of the achievements
        switch self {
        case .alphabet, .word, .sentence: 100
        }
    }
}
```

```swift
gameCenter.achieve(EnglishAchievement.word)
```
