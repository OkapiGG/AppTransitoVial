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
    let onShowCatalog: (() -> Void)?
    let showsBackButton: Bool

    init(
        onShowCatalog: (() -> Void)? = nil,
        showsBackButton: Bool = true
    ) {
        self.onShowCatalog = onShowCatalog
        self.showsBackButton = showsBackButton
    }

    private let sections: [SignalPurposeSection] = [
        SignalPurposeSection(
            title: "Restrictivas",
            description: "Indican limitaciones, prohibiciones o restricciones legales sobre el uso de la via. Su cumplimiento es obligatorio.",
            accent: Color(red: 0.96, green: 0.38, blue: 0.33),
            cards: [
                SignalPurposeCard(
                    title: "ALTO",
                    description: "Obligatorio detenerse por completo antes de continuar.",
                    kindLabel: "Señal reglamentaria",
                    icon: "stop.fill",
                    accent: Color(red: 0.96, green: 0.38, blue: 0.33),
                    signStyle: .octagon
                ),
                SignalPurposeCard(
                    title: "NO ENTRAR",
                    description: "Prohibe el acceso de vehiculos en ese sentido.",
                    kindLabel: "Señal reglamentaria",
                    icon: "minus",
                    accent: Color(red: 0.96, green: 0.38, blue: 0.33),
                    signStyle: .circle
                ),
                SignalPurposeCard(
                    title: "LIMITE 80",
                    description: "Indica la velocidad maxima permitida en la via.",
                    kindLabel: "Señal reglamentaria",
                    icon: "number.circle.fill",
                    accent: Color(red: 0.96, green: 0.38, blue: 0.33),
                    signStyle: .speedLimit
                )
            ],
            filter: .restrictive
        ),
        SignalPurposeSection(
            title: "Preventivas",
            description: "Advierten a los usuarios sobre la existencia de un peligro o situaciones imprevistas en la ruta.",
            accent: Color(red: 0.91, green: 0.67, blue: 0.22),
            cards: [
                SignalPurposeCard(
                    title: "CURVA",
                    description: "Advierte una curva peligrosa mas adelante.",
                    kindLabel: "Señal preventiva",
                    icon: "arrow.turn.up.right",
                    accent: Color(red: 0.91, green: 0.67, blue: 0.22),
                    signStyle: .diamond
                ),
                SignalPurposeCard(
                    title: "ESCUELA",
                    description: "Indica zona escolar y pide reducir velocidad.",
                    kindLabel: "Señal preventiva",
                    icon: "graduationcap.fill",
                    accent: Color(red: 0.91, green: 0.67, blue: 0.22),
                    signStyle: .diamond
                ),
                SignalPurposeCard(
                    title: "PELIGRO",
                    description: "Señala un riesgo o condicion imprevista en la via.",
                    kindLabel: "Señal preventiva",
                    icon: "exclamationmark",
                    accent: Color(red: 0.91, green: 0.67, blue: 0.22),
                    signStyle: .diamond
                )
            ],
            filter: .preventive
        ),
        SignalPurposeSection(
            title: "Informativas",
            description: "Guian al usuario, proporcionando informacion sobre destinos, servicios y lugares de interes.",
            accent: Color(red: 0.29, green: 0.53, blue: 0.98),
            cards: [
                SignalPurposeCard(
                    title: "HOSPITAL",
                    description: "Indica la cercania de servicios medicos.",
                    kindLabel: "Señal informativa",
                    icon: "cross.case.fill",
                    accent: Color(red: 0.29, green: 0.53, blue: 0.98),
                    signStyle: .square
                ),
                SignalPurposeCard(
                    title: "GASOLINERA",
                    description: "Muestra un punto de abastecimiento de combustible.",
                    kindLabel: "Señal informativa",
                    icon: "fuelpump.fill",
                    accent: Color(red: 0.29, green: 0.53, blue: 0.98),
                    signStyle: .square
                ),
                SignalPurposeCard(
                    title: "PARKING",
                    description: "Marca una zona habilitada para estacionamiento.",
                    kindLabel: "Señal informativa",
                    icon: "parkingsign",
                    accent: Color(red: 0.29, green: 0.53, blue: 0.98),
                    signStyle: .square
                )
            ],
            filter: .informative
        )
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
                if showsBackButton {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 36, height: 36)
                    }
                    .buttonStyle(.plain)
                }

                Spacer()

                Button {
                    onShowCatalog?()
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

}

private struct SignalSectionView: View {
    let section: SignalPurposeSection

    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

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
        VStack(alignment: .leading, spacing: 12) {
            signArtwork

            Text(card.title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Text(card.description)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.62))
                .fixedSize(horizontal: false, vertical: true)

            Text(card.kindLabel)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(card.accent)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 236, alignment: .topLeading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.04), lineWidth: 1)
                )
        )
    }

    private var signArtwork: some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(card.accent.opacity(0.1))
            .frame(height: 118)
            .overlay {
                ZStack {
                    switch card.signStyle {
                    case .diamond:
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(red: 0.22, green: 0.21, blue: 0.24))
                            .frame(width: 62, height: 62)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .stroke(card.accent, lineWidth: 3)
                            )
                            .rotationEffect(.degrees(45))
                    case .circle:
                        Circle()
                            .fill(card.accent)
                            .frame(width: 62, height: 62)
                            .overlay(
                                Circle()
                                    .stroke(.white, lineWidth: 6)
                            )
                    case .square:
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(card.accent)
                            .frame(width: 62, height: 62)
                    case .octagon:
                        OctagonShape()
                            .fill(card.accent)
                            .frame(width: 66, height: 66)
                    case .speedLimit:
                        Circle()
                            .fill(.white)
                            .frame(width: 64, height: 64)
                            .overlay(
                                Circle()
                                    .stroke(card.accent, lineWidth: 5)
                            )
                    }

                    if card.signStyle == .speedLimit {
                        Text("80")
                            .font(.system(size: 22, weight: .black, design: .rounded))
                            .foregroundStyle(.black)
                    } else {
                        Image(systemName: card.icon)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(card.signStyle == .circle ? .white : card.accent)
                    }
                }
            }
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
    let description: String
    let kindLabel: String
    let icon: String
    let accent: Color
    let signStyle: SignalPurposeSignStyle
}

private enum SignalPurposeSignStyle {
    case octagon
    case circle
    case speedLimit
    case diamond
    case square
}

private struct OctagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let insetX = width * 0.28
        let insetY = height * 0.28

        var path = Path()
        path.move(to: CGPoint(x: insetX, y: 0))
        path.addLine(to: CGPoint(x: width - insetX, y: 0))
        path.addLine(to: CGPoint(x: width, y: insetY))
        path.addLine(to: CGPoint(x: width, y: height - insetY))
        path.addLine(to: CGPoint(x: width - insetX, y: height))
        path.addLine(to: CGPoint(x: insetX, y: height))
        path.addLine(to: CGPoint(x: 0, y: height - insetY))
        path.addLine(to: CGPoint(x: 0, y: insetY))
        path.closeSubpath()
        return path
    }
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
