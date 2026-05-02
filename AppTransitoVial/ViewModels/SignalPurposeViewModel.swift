//
//  SignalPurposeViewModel.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 30/04/26.
//

import Combine
import SwiftUI

final class SignalPurposeViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedFilter: SignalPurposeFilter = .all

    let sections = SignalPurposeSection.defaultSections

    var visibleSections: [SignalPurposeSection] {
        sections.compactMap { section in
            guard selectedFilter == .all || section.filter == selectedFilter else {
                return nil
            }

            let filteredCards = section.cards.filter(matchesSearch)
            guard !filteredCards.isEmpty else {
                return nil
            }

            return SignalPurposeSection(
                title: section.title,
                description: section.description,
                accent: section.accent,
                cards: filteredCards,
                filter: section.filter
            )
        }
    }

    private func matchesSearch(_ card: SignalPurposeCard) -> Bool {
        searchText.isEmpty ||
        card.title.localizedCaseInsensitiveContains(searchText) ||
        card.description.localizedCaseInsensitiveContains(searchText)
    }
}

struct SignalPurposeSection: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let accent: Color
    let cards: [SignalPurposeCard]
    let filter: SignalPurposeFilter

    static let defaultSections: [SignalPurposeSection] = [
        SignalPurposeSection(
            title: "Restrictivas",
            description: "Indican limitaciones, prohibiciones o restricciones legales sobre el uso de la via. Su cumplimiento es obligatorio.",
            accent: .purposeRestrictive,
            cards: [
                SignalPurposeCard(title: "ALTO", description: "Obligatorio detenerse por completo antes de continuar.", kindLabel: "Señal reglamentaria", icon: "stop.fill", accent: .purposeRestrictive, signStyle: .octagon),
                SignalPurposeCard(title: "NO ENTRAR", description: "Prohibe el acceso de vehiculos en ese sentido.", kindLabel: "Señal reglamentaria", icon: "minus", accent: .purposeRestrictive, signStyle: .circle),
                SignalPurposeCard(title: "LIMITE 80", description: "Indica la velocidad maxima permitida en la via.", kindLabel: "Señal reglamentaria", icon: "number.circle.fill", accent: .purposeRestrictive, signStyle: .speedLimit)
            ],
            filter: .restrictive
        ),
        SignalPurposeSection(
            title: "Preventivas",
            description: "Advierten a los usuarios sobre la existencia de un peligro o situaciones imprevistas en la ruta.",
            accent: .purposePreventive,
            cards: [
                SignalPurposeCard(title: "CURVA", description: "Advierte una curva peligrosa mas adelante.", kindLabel: "Señal preventiva", icon: "arrow.turn.up.right", accent: .purposePreventive, signStyle: .diamond),
                SignalPurposeCard(title: "ESCUELA", description: "Indica zona escolar y pide reducir velocidad.", kindLabel: "Señal preventiva", icon: "graduationcap.fill", accent: .purposePreventive, signStyle: .diamond),
                SignalPurposeCard(title: "PELIGRO", description: "Señala un riesgo o condicion imprevista en la via.", kindLabel: "Señal preventiva", icon: "exclamationmark", accent: .purposePreventive, signStyle: .diamond)
            ],
            filter: .preventive
        ),
        SignalPurposeSection(
            title: "Informativas",
            description: "Guian al usuario, proporcionando informacion sobre destinos, servicios y lugares de interes.",
            accent: .purposeInformative,
            cards: [
                SignalPurposeCard(title: "HOSPITAL", description: "Indica la cercania de servicios medicos.", kindLabel: "Señal informativa", icon: "cross.case.fill", accent: .purposeInformative, signStyle: .square),
                SignalPurposeCard(title: "GASOLINERA", description: "Muestra un punto de abastecimiento de combustible.", kindLabel: "Señal informativa", icon: "fuelpump.fill", accent: .purposeInformative, signStyle: .square),
                SignalPurposeCard(title: "PARKING", description: "Marca una zona habilitada para estacionamiento.", kindLabel: "Señal informativa", icon: "parkingsign", accent: .purposeInformative, signStyle: .square)
            ],
            filter: .informative
        )
    ]
}

struct SignalPurposeCard: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let kindLabel: String
    let icon: String
    let accent: Color
    let signStyle: SignalPurposeSignStyle
}

enum SignalPurposeSignStyle {
    case octagon
    case circle
    case speedLimit
    case diamond
    case square
}

enum SignalPurposeFilter: String, CaseIterable, Identifiable {
    case all
    case restrictive
    case preventive
    case informative

    var id: String { rawValue }

    var title: String {
        switch self {
        case .all:
            return "Todas"
        case .restrictive:
            return "Restrictivas"
        case .preventive:
            return "Preventivas"
        case .informative:
            return "Informativas"
        }
    }

    var icon: String? {
        switch self {
        case .all:
            return nil
        case .restrictive:
            return "nosign"
        case .preventive:
            return "exclamationmark.triangle.fill"
        case .informative:
            return "info.circle.fill"
        }
    }

    var activeColor: Color {
        switch self {
        case .all, .informative:
            return .purposeInformative
        case .restrictive:
            return .purposeRestrictive
        case .preventive:
            return .purposePreventive
        }
    }
}

private extension Color {
    static let purposeRestrictive = Color(red: 0.96, green: 0.38, blue: 0.33)
    static let purposePreventive = Color(red: 0.91, green: 0.67, blue: 0.22)
    static let purposeInformative = Color(red: 0.29, green: 0.53, blue: 0.98)
}
