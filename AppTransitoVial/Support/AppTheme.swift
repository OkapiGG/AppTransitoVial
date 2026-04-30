//
//  AppTheme.swift
//  AppTransitoVial
//
//  Created by Codex on 30/04/26.
//

import SwiftUI
import UIKit

enum AppTheme {
    static let screenBackground = Color(red: 0.06, green: 0.09, blue: 0.13)
    static let tabBarBackground = Color(red: 0.05, green: 0.08, blue: 0.12)
    static let primaryAccent = Color.blue
    static let cardBackground = Color.white.opacity(0.05)
    static let cardBorder = Color.white.opacity(0.05)
    static let mutedText = Color.white.opacity(0.65)
    static let secondaryText = Color.white.opacity(0.55)
    static let searchFieldBackground = Color.white.opacity(0.08)
    static let chipBackground = Color.white.opacity(0.08)

    static func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(tabBarBackground)

        let normalColor = UIColor(white: 0.72, alpha: 1)
        let selectedColor = UIColor(primaryAccent)

        let layouts = [
            appearance.stackedLayoutAppearance,
            appearance.inlineLayoutAppearance,
            appearance.compactInlineLayoutAppearance
        ]

        layouts.forEach { layout in
            layout.normal.iconColor = normalColor
            layout.normal.titleTextAttributes = [.foregroundColor: normalColor]
            layout.selected.iconColor = selectedColor
            layout.selected.titleTextAttributes = [.foregroundColor: selectedColor]
        }

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
