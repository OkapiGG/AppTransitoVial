//
//  LoginView.swift
//  AppTransitoVial
//
//  Created by Emanuel Perez Altuzar on 10/03/26.
//

import SwiftUI
import UIKit
import CoreLocation

struct InicioView: View {
    @State private var seleccion: Int = 1
    @State private var isShowingReports: Bool = false
    @State private var selectedLocationName = "Ubicación no seleccionada"
    @State private var selectedCoordinate: CLLocationCoordinate2D?

    init() {
        AppTheme.configureTabBarAppearance()
    }

    var body: some View {
        TabView(selection: $seleccion) {
            InicioTabRootView(
                selectedLocationName: $selectedLocationName,
                selectedCoordinate: $selectedCoordinate,
                isShowingReports: $isShowingReports
            )
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
                LeccionView()
            }
            .tabItem {
                Label("Lecciones", systemImage: "graduationcap.fill")
            }
            .tag(4)
        }
        .tint(AppTheme.primaryAccent)
        .toolbarBackground(AppTheme.tabBarBackground, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
        .sheet(isPresented: $isShowingReports) {
            ReportsView()
        }
    }
}

private enum InicioRoute: Hashable {
    case signalPurposes
    case signalCatalog
}

private struct InicioTabRootView: View {
    @Binding var selectedLocationName: String
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var isShowingReports: Bool
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

                    MapCard(
                        selectedLocationName: $selectedLocationName,
                        selectedCoordinate: $selectedCoordinate
                    )
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

                        Button {
                            isShowingReports = true
                        } label: {
                            Label("Reportar una señal", systemImage: "camera.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal)

                    HStack(spacing: 15) {
                        InfoCard(icon: "graduationcap.fill", title: "Lecciones", subtitle: "12 nuevas guías", color: .blue)
                        InfoCard(icon: "star.fill", title: "Progreso", subtitle: "Nivel 4 Alcanzado", color: .yellow)
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
