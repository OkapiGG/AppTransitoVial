//
//  CatalogoSenalViewModel.swift
//  AppTransitoVial
//
//  Created by Codex on 18/04/26.
//

import SwiftUI
import Combine

final class CatalogoSenalViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedCategory: SignalCatalogFilter = .all

    let sections = SignalCatalogSection.allSections

    var visibleSections: [SignalCatalogSection] {
        if selectedCategory == .all {
            let allSignals = sections
                .flatMap { $0.signals }
                .filter(matchesSearch)

            guard !allSignals.isEmpty else {
                return []
            }

            return [
                SignalCatalogSection(
                    title: SignalCatalogSection.allSignalsSection.title,
                    description: SignalCatalogSection.allSignalsSection.description,
                    accent: SignalCatalogSection.allSignalsSection.accent,
                    filter: SignalCatalogSection.allSignalsSection.filter,
                    signals: allSignals
                )
            ]
        }

        return sections.compactMap { section in
            guard selectedCategory == section.filter else {
                return nil
            }

            let filteredSignals = section.signals.filter(matchesSearch)
            guard !filteredSignals.isEmpty else {
                return nil
            }

            return SignalCatalogSection(
                title: section.title,
                description: section.description,
                accent: section.accent,
                filter: section.filter,
                signals: filteredSignals
            )
        }
    }

    private func matchesSearch(_ signal: SignalCatalogItem) -> Bool {
        searchText.isEmpty ||
        signal.title.localizedCaseInsensitiveContains(searchText) ||
        signal.description.localizedCaseInsensitiveContains(searchText)
    }
}
