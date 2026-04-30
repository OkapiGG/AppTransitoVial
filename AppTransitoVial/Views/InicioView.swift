//
//  LoginView.swift
//  AppTransitoVial
//
//  Created by Emanuel Perez Altuzar on 10/03/26.
//

import SwiftUI
import UIKit

struct InicioView: View {
    @State private var seleccion: Int = 1

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color(red: 0.05, green: 0.08, blue: 0.12))

        let normalColor = UIColor(white: 0.72, alpha: 1)
        let selectedColor = UIColor.systemBlue

        appearance.stackedLayoutAppearance.normal.iconColor = normalColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor]
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]

        appearance.inlineLayoutAppearance.normal.iconColor = normalColor
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor]
        appearance.inlineLayoutAppearance.selected.iconColor = selectedColor
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]

        appearance.compactInlineLayoutAppearance.normal.iconColor = normalColor
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor]
        appearance.compactInlineLayoutAppearance.selected.iconColor = selectedColor
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $seleccion) {
            InicioTabRootView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
                .tag(1)

            NavigationStack {
                CatalogoSenalView(showsBackButton: false)
            }
            .tabItem {
                Label("Catalago", systemImage: "rectangle.3.group")
            }
            .tag(2)

            PropositosTabRootView()
            .tabItem {
                Label("Propósitos", systemImage: "exclamationmark.triangle.fill")
            }
            .tag(3)

            NavigationStack {
                PerfilView()
            }
            .tabItem {
                Label("Lecciones", systemImage: "graduationcap.fill")
            }
            .tag(4)
        }
        .tint(.blue)
        .toolbarBackground(Color(red: 0.05, green: 0.08, blue: 0.12), for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
    }
}

private enum InicioRoute: Hashable {
    case signalPurposes
    case signalCatalog
}

private struct InicioTabRootView: View {
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color(Color.background)
                    .ignoresSafeArea()

                VStack(spacing: 25) {
                    HStack {
                        Image(systemName: "line.3.horizontal")
                        Spacer()
                        Text("SeñalVial")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "bell.fill")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal)

                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 220)

                        Image("calle")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 25))

                        HStack {
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                        .padding()
                    }
                    .padding(.horizontal)

                    VStack(spacing: 10) {
                        Text("¡Bienvenido a\nSeñalVial!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)

                        Text("Aprende el significado de las señales de tránsito y ayuda a mejorar la seguridad vial de tu ciudad.")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }

                    VStack(spacing: 15) {
                        Button {
                            navigationPath.append(InicioRoute.signalPurposes)
                        } label: {
                            Label("Ver señales de tránsito", systemImage: "book.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal)

                    HStack(spacing: 15) {
                        InfoCard(icon: "graduationcap.fill", title: "Lecciones", subtitle: " Completadas ", color: .blue)
                        InfoCard(icon: "star.fill", title: "Progreso", subtitle: "Nivel  ", color: .yellow)
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .navigationDestination(for: InicioRoute.self) { route in
                switch route {
                case .signalPurposes:
                    PropositosSeñalesView(
                        onShowCatalog: {
                            navigationPath.append(InicioRoute.signalCatalog)
                        },
                        showsBackButton: true
                    )
                case .signalCatalog:
                    CatalogoSenalView(showsBackButton: true)
                }
            }
        }
    }
}

private struct PropositosTabRootView: View {
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            PropositosSeñalesView(
                onShowCatalog: {
                    navigationPath.append(InicioRoute.signalCatalog)
                },
                showsBackButton: false
            )
            .navigationDestination(for: InicioRoute.self) { route in
                switch route {
                case .signalPurposes:
                    PropositosSeñalesView(
                        onShowCatalog: {
                            navigationPath.append(InicioRoute.signalCatalog)
                        },
                        showsBackButton: true
                    )
                case .signalCatalog:
                    CatalogoSenalView(showsBackButton: true)
                }
            }
        }
    }
}

#Preview {
    InicioView()
}
