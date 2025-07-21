//
//  AchievementConcrete.swift
//  swift-gamecenter
//
//  Created by 이재성 on 7/22/25.
//

import GameCenterModule

enum EnglishAchievement: AchievementProtocol, CaseIterable {
    case alphabet
    case word
    case sentence
    
    var id: String {
        switch self {
        case .alphabet:
            "gamecenter.achievement.alphabet"
        case .word:
            "gamecenter.achievement.word"
        case .sentence:
            "gamecenter.achievement.sentence"
        }
    }
    
    var percentageUnit: Double {
        switch self {
        case .alphabet:
            3.5
        case .word:
            10
        case .sentence:
            10
        }
    }
    
}
