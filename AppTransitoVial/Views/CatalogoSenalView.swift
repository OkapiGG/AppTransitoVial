//
//  Señales.swift
//  AppTransitoVial
//
//  Created by ADMIN UNACH on 12/03/26.
//

import SwiftUI

struct CatalogoSenalView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CatalogoSenalViewModel()
    let showsBackButton: Bool

    init(showsBackButton: Bool = true) {
        self.showsBackButton = showsBackButton
    }

    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.09, blue: 0.13)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                header
                searchBar
                filterChips

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        ForEach(viewModel.visibleSections) { section in
                            SignalCatalogSectionView(section: section)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
            }
            .padding(.top, 8)
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        ZStack {
            Text("Catalagos de Señales")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            HStack {
                if showsBackButton {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                    }
                    .buttonStyle(.plain)
                }

                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.white.opacity(0.42))

            TextField("", text: $viewModel.searchText, prompt: Text("Buscar señal por nombre o uso").foregroundStyle(Color.white.opacity(0.28)))
                .foregroundStyle(.white)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        }
        .padding(.horizontal, 14)
        .frame(height: 48)
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 20)
    }

    private var filterChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(SignalCatalogFilter.allCases) { category in
                    Button {
                        viewModel.selectedCategory = category
                    } label: {
                        HStack(spacing: 6) {
                            if let icon = category.icon {
                                Image(systemName: icon)
                                    .font(.system(size: 11, weight: .bold))
                            }

                            Text(category.title)
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 14)
                        .frame(height: 36)
                        .background(viewModel.selectedCategory == category ? category.activeColor : Color.white.opacity(0.08))
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

private struct SignalCatalogSectionView: View {
    let section: SignalCatalogSection

    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 10) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(section.accent)
                    .frame(width: 5, height: 30)

                VStack(alignment: .leading, spacing: 6) {
                    Text(section.title)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.white)

                    Text(section.description)
                        .font(.subheadline)
                        .foregroundStyle(Color.white.opacity(0.55))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(section.signals) { signal in
                    SignalCatalogCard(item: signal)
                }
            }
        }
    }
}

private struct SignalCatalogCard: View {
    let item: SignalCatalogItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(item.accent.opacity(0.12))
                    .frame(height: 92)

                if item.diamond {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(item.accent.opacity(0.8), lineWidth: 2)
                        .frame(width: 48, height: 48)
                        .rotationEffect(.degrees(45))
                }

                Image(systemName: item.icon)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(item.accent)
            }

            Text(item.title)
                .font(.headline)
                .foregroundStyle(.white)

            Text(item.description)
                .font(.caption)
                .foregroundStyle(Color.white.opacity(0.65))
                .fixedSize(horizontal: false, vertical: true)

            Text(item.classificationText)
                .font(.caption.weight(.semibold))
                .foregroundStyle(item.accent)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Color.white.opacity(0.05), lineWidth: 1)
                )
        )
    }
}

#Preview {
    CatalogoSenalView()
}
