//
//  Señales.swift
//  AppTransitoVial
//
//  Created by ADMIN UNACH on 12/03/26.
//

import SwiftUI

struct CatalogoSenalView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var selectedCategory: String = "Todas"
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    private let categories = ["Todas", "Reglamentarias", "Preventivas"]

    var body: some View {
        NavigationView {
            ZStack {
                Color(Color.background)
                    .ignoresSafeArea()

                VStack(spacing: 15) {
                    ZStack {
                        Text("Señales Comunes")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)

                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .frame(width: 44, height: 44)
                            }
                            .buttonStyle(.plain)

                            Spacer()
                        }
                    }
                    .padding(.horizontal)

                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white.opacity(0.7))
                            TextField("Buscar señal...", text: $searchText)
                                .foregroundColor(.white)
                                .tint(.white)
                        }
                        .padding(10)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    HStack(spacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                Text(category)
                                    .font(.subheadline.weight(.semibold))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(selectedCategory == category ? Color.blue : Color.white.opacity(0.12))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                            }
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
                    .fill(Color.white.opacity(0.1))
                    .frame(height: 100)
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .foregroundColor(color)
            }
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
            Text(description)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
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
