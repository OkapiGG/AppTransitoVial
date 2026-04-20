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
                        MapCard(
                            selectedLocationName: $selectedLocationName,
                            selectedCoordinate: $selectedCoordinate
                        )
                        
                        Image("calle")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 220)

                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        Text("¡Bienvenido!")
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
                        Button(action: {
                            seleccion = 2
                        }) {
                            Label("Ver señales de tránsito", systemImage: "book.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        
                        Button(action: {
                            isShowingReports = true
                        }) {
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
            .tabItem {
                Label("Inicio", systemImage: "house")
            }
            
            CatalogoSenalView()
                .tabItem {
                    Label("Catalago", systemImage: "rectangle.3.group")
                }
                .tag(2)
            
            PropositosSeñalesView()
                .tabItem {
                    Label("Propósitos", systemImage: "exclamationmark.triangle.fill")
                }
            .tag(3)
            
            PerfilView()
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle")
                }
            
        }
        .tint(.blue)
        .toolbarBackground(Color(red: 0.05, green: 0.08, blue: 0.12), for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
        .sheet(isPresented: $isShowingReports) {
            ReportsView()
        }
    }
}

#Preview {
    InicioView()
}
