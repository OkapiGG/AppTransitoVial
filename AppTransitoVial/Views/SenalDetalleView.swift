//
//  SenalDetalleView.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 01/05/26.
//

import SwiftUI

struct SenalDetalleView: View {
    let item: SignalCatalogItem
    @Environment(\.dismiss) private var dismiss
    
    private func imageFor(name: String) -> some View {
        Group {
            if UIImage(named: name) != nil {
                Image(name)
                    .resizable()
            } else {
                Image(systemName: name)
                    .resizable()
                    .font(.system(size: 80, weight: .bold))
                    .foregroundStyle(item.accent)
            }
        }
    }
    
    var body: some View {
        ZStack {
            AppTheme.screenBackground
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header (Botón atrás)
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(Circle().fill(.white.opacity(0.1)))
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        // Nombre de la señal
                        Text(item.title)
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                        
                        // Contenedor de la Imagen
                        ZStack {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(item.accent.opacity(0.15))
                                .frame(height: 250)
                            
                            if item.diamond {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(item.accent, lineWidth: 5)
                                    .frame(width: 140, height: 140)
                                    .rotationEffect(.degrees(45))
                            }
                            
                            imageFor(name: item.icon)
                                .scaledToFit()
                                .frame(width: 140, height: 140)
                        }
                        .padding(.horizontal, 20)
                        
                        // Información Detallada
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("¿Qué significa?")
                                    .font(.headline)
                                    .foregroundStyle(item.accent)
                                
                                Text(item.description)
                                    .font(.body)
                                    .foregroundStyle(.white.opacity(0.9))
                                    .lineSpacing(4)
                            }
                            
                            Divider().background(.white.opacity(0.2))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Clasificación")
                                    .font(.headline)
                                    .foregroundStyle(item.accent)
                                
                                Text(item.classificationText)
                                    .font(.subheadline)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Capsule().fill(item.accent.opacity(0.2)))
                            }
                        }
                        .padding(25)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(AppTheme.cardBackground)
                                .overlay(RoundedRectangle(cornerRadius: 24).stroke(AppTheme.cardBorder, lineWidth: 1))
                        )
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        CatalogoSenalView()
    }
}
