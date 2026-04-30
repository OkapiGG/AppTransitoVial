//
//  PropositosSeñalesView.swift
//  AppTransitoVial
//
//  Created by Emanuel Perez Altuzar on 10/03/26.
//

import SwiftUI

struct PropositosSeñalesView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SignalPurposeViewModel()
    let onShowCatalog: (() -> Void)?
    let showsBackButton: Bool

    init(
        onShowCatalog: (() -> Void)? = nil,
        showsBackButton: Bool = true
    ) {
        self.onShowCatalog = onShowCatalog
        self.showsBackButton = showsBackButton
    }

    var body: some View {
        ZStack {
            AppTheme.screenBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        searchBar
                        filterChips

                        ForEach(viewModel.visibleSections) { section in
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

            TextField("", text: $viewModel.searchText, prompt: Text("Buscar una señal específica").foregroundStyle(Color.white.opacity(0.28)))
                .foregroundStyle(.white)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        }
        .padding(.horizontal, 14)
        .frame(height: 48)
        .background(AppTheme.searchFieldBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    private var filterChips: some View {
        HStack(spacing: 10) {
            ForEach(SignalPurposeFilter.allCases) { filter in
                Button {
                    viewModel.selectedFilter = filter
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
                    .background(viewModel.selectedFilter == filter ? filter.activeColor : AppTheme.chipBackground)
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

#Preview {
    PropositosSeñalesView()
}
