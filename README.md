<img width=50% src="https://github.com/user-attachments/assets/e85e5fc1-75ee-4f0e-8c13-22576c45f2e4" alt="game-center-og"/>

# Game Center

Swift6+
iOS17+

<table>
  <tr valign="center">
    <td align="center" width="25%">
      <img src="https://github.com/user-attachments/assets/34c307c4-cd44-481e-b5c2-39bda68aefd7" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-22 at 03 20 28"/>
    </td>
    <td align="center" width="25%">
      <img src="https://github.com/user-attachments/assets/56b1ce0e-3c0b-49d1-8428-431d2401c932" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-22 at 03 20 14"/>
    </td>
  </tr>
</table>

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
