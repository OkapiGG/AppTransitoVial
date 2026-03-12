//
//  Señales.swift
//  AppTransitoVial
//
//  Created by ADMIN UNACH on 12/03/26.
//

import SwiftUI

struct CatalogoSenalView: View {
    @State private var searchText = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView {
            
            VStack(spacing: 15) {
                Text("Señales Comunes")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Buscar señal...", text: $searchText)
                            .foregroundColor(.primary)
                    }
                    .padding(10)
                    .background(Color(.systemGray5))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                HStack(spacing: 10) {
                    Button(action: {}) {
                        Text("Todas")
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    Button(action: {}) {
                        Text("Reglamentarias")
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    Button(action: {}) {
                        Text("Preventivas")
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                }
                .padding(.horizontal)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        SignalCard(
                            title: "Alto",
                            description: "Obligatorio detenerse por completo antes de avanzar.",
                            icon: "hand.raised.fill",
                            color: .red
                        )
                        SignalCard(
                            title: "Ceda el paso",
                            description: "Dar prioridad a los vehículos que ya están circulando.",
                            icon: "triangle.fill",
                            color: .blue
                        )
                        SignalCard(
                            title: "Semáforo",
                            description: "Seguir las indicaciones de las luces de tránsito.",
                            icon: "trafficlight.fill",
                            color: .yellow
                        )
                        SignalCard(
                            title: "Cruce peatonal",
                            description: "Zona designada para el paso seguro de peatones.",
                            icon: "figure.walk",
                            color: .blue
                        )
                        SignalCard(
                            title: "Límite velocidad",
                            description: "Máximo de velocidad permitido en este tramo.",
                            icon: "speedometer",
                            color: .gray
                        )
                        SignalCard(
                            title: "Curva peligrosa",
                            description: "Indica una reducción de velocidad por giro cerrado.",
                            icon: "arrow.turn.up.right",
                            color: .orange
                        )
                    }
                    .padding()
                }
            }
        }
    }
}

struct SignalCard: View {
    var title: String
    var description: String
    var icon: String
    var color: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemGray6))
                    .frame(height: 100)
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .foregroundColor(color)
            }
            Text(title)
                .font(.headline)
            Text(description)
                .font(.caption)
                .foregroundColor(.gray)
            Button(action: {}) {
                Text("Ver más >")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    CatalogoSenalView()
}
