//
//  PropositosSeñalesView.swift
//  AppTransitoVial
//
//  Created by Emanuel Perez Altuzar on 10/03/26.
//

import SwiftUI

struct PropositosSeñalesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var selectedFilter: SignalPurposeFilter = .all

    private let sections: [SignalPurposeSection] = [
        SignalPurposeSection(
            title: "Restrictivas",
            description: "Indican limitaciones, prohibiciones o restricciones legales sobre el uso de la via. Su cumplimiento es obligatorio.",
            accent: Color(red: 0.96, green: 0.38, blue: 0.33),
            cards: [
                SignalPurposeCard(title: "ALTO", icon: "stop.fill", accent: Color(red: 0.96, green: 0.38, blue: 0.33)),
                SignalPurposeCard(title: "NO ENTRAR", icon: "xmark", accent: Color(red: 0.96, green: 0.38, blue: 0.33)),
                SignalPurposeCard(title: "LIMITE 80", icon: "gauge.with.dots.needle.33percent", accent: Color(red: 0.96, green: 0.38, blue: 0.33))
            ],
            filter: .restrictive
        ),
        SignalPurposeSection(
            title: "Preventivas",
            description: "Advierten a los usuarios sobre la existencia de un peligro o situaciones imprevistas en la ruta.",
            accent: Color(red: 0.91, green: 0.67, blue: 0.22),
            cards: [
                SignalPurposeCard(title: "CURVA", icon: "arrow.turn.up.right", accent: Color(red: 0.91, green: 0.67, blue: 0.22), diamond: true),
                SignalPurposeCard(title: "ESCUELA", icon: "graduationcap.fill", accent: Color(red: 0.91, green: 0.67, blue: 0.22), diamond: true),
                SignalPurposeCard(title: "PELIGRO", icon: "exclamationmark", accent: Color(red: 0.91, green: 0.67, blue: 0.22), diamond: true)
            ],
            filter: .preventive
        ),
        SignalPurposeSection(
            title: "Informativas",
            description: "Guian al usuario, proporcionando informacion sobre destinos, servicios y lugares de interes.",
            accent: Color(red: 0.29, green: 0.53, blue: 0.98),
            cards: [
                SignalPurposeCard(title: "HOSPITAL", icon: "cross.case.fill", accent: Color(red: 0.29, green: 0.53, blue: 0.98)),
                SignalPurposeCard(title: "GASOLINERA", icon: "fuelpump.fill", accent: Color(red: 0.29, green: 0.53, blue: 0.98)),
                SignalPurposeCard(title: "PARKING", icon: "parkingsign", accent: Color(red: 0.29, green: 0.53, blue: 0.98))
            ],
            filter: .informative
        )
    ]

    private let bottomItems: [BottomBarItem] = [
        BottomBarItem(title: "Inicio", icon: "house.fill"),
        BottomBarItem(title: "Señales", icon: "triangle.circle.fill", isSelected: true),
        BottomBarItem(title: "Trivia", icon: "questionmark.square.fill"),
        BottomBarItem(title: "Reportar", icon: "exclamationmark.circle.fill"),
        BottomBarItem(title: "Perfil", icon: "person.fill")
    ]

    private var visibleSections: [SignalPurposeSection] {
        sections.compactMap { section in
            guard selectedFilter == .all || section.filter == selectedFilter else {
                return nil
            }

            let filteredCards = section.cards.filter { card in
                searchText.isEmpty || card.title.localizedCaseInsensitiveContains(searchText)
            }

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

    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.09, blue: 0.13)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        searchBar
                        filterChips

                        ForEach(visibleSections) { section in
                            SignalSectionView(section: section)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 14)
                    .padding(.bottom, 28)
                }

                bottomBar
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        ZStack {
            Text("Tipos de Señales")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 36)
                }
                .buttonStyle(.plain)

                Spacer()

                Button {
                } label: {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                        .frame(width: 36, height: 36)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 14)
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.white.opacity(0.35))

            TextField("", text: $searchText, prompt: Text("Buscar una señal específica").foregroundStyle(Color.white.opacity(0.28)))
                .foregroundStyle(.white)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        }
        .padding(.horizontal, 14)
        .frame(height: 48)
        .background(Color.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    private var filterChips: some View {
        HStack(spacing: 10) {
            ForEach(SignalPurposeFilter.allCases) { filter in
                Button {
                    selectedFilter = filter
                } label: {
                    HStack(spacing: 6) {
                        if let icon = filter.icon {
                            Image(systemName: icon)
                                .font(.system(size: 10, weight: .bold))
                        }

                        Text(filter.title)
                            .font(.system(size: 13, weight: .semibold))
                            .lineLimit(1)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .frame(height: 34)
                    .background(selectedFilter == filter ? filter.activeColor : Color.white.opacity(0.08))
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var bottomBar: some View {
        HStack {
            ForEach(bottomItems) { item in
                VStack(spacing: 6) {
                    Image(systemName: item.icon)
                        .font(.system(size: 16, weight: item.isSelected ? .bold : .semibold))
                    Text(item.title)
                        .font(.system(size: 10, weight: .semibold))
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(item.isSelected ? Color(red: 0.27, green: 0.58, blue: 0.99) : Color.white.opacity(0.42))
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 14)
        .padding(.bottom, 10)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(red: 0.08, green: 0.11, blue: 0.16))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.white.opacity(0.04), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.25), radius: 18, y: -4)
        )
        .padding(.horizontal, 12)
        .padding(.bottom, 8)
    }
}

private struct SignalSectionView: View {
    let section: SignalPurposeSection

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 10) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(section.accent)
                    .frame(width: 5, height: 26)

                VStack(alignment: .leading, spacing: 6) {
                    Text(section.title)
                        .font(.system(size: 31 / 2, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Text(section.description)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.white.opacity(0.45))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(section.cards) { card in
                    SignalPurposeCardView(card: card)
                }
            }
        }
    }
}

private struct SignalPurposeCardView: View {
    let card: SignalPurposeCard

    var body: some View {
        VStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(card.accent.opacity(0.12))
                    .frame(width: 48, height: 48)

                if card.diamond {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(card.accent.opacity(0.8), lineWidth: 2)
                        .frame(width: 38, height: 38)
                        .rotationEffect(.degrees(45))
                }

                Image(systemName: card.icon)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(card.accent)
            }

            Text(card.title)
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 108)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.04), lineWidth: 1)
                )
        )
    }
}

private struct SignalPurposeSection: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let accent: Color
    let cards: [SignalPurposeCard]
    let filter: SignalPurposeFilter
}

private struct SignalPurposeCard: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let accent: Color
    var diamond: Bool = false
}

private struct BottomBarItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    var isSelected: Bool = false
}

private enum SignalPurposeFilter: String, CaseIterable, Identifiable {
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
            return Color(red: 0.27, green: 0.58, blue: 0.99)
        case .restrictive:
            return Color(red: 0.96, green: 0.38, blue: 0.33)
        case .preventive:
            return Color(red: 0.91, green: 0.67, blue: 0.22)
        }
    }
}

#Preview {
    PropositosSeñalesView()
}
