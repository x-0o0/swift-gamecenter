//
//  Achievement.swift
//  swift-gamecenter
//
//  Created by 이재성 on 7/20/25.
//

public protocol AchievementProtocol: Identifiable {
    var id: String { get }
    var percentageUnit: Double { get }
}
