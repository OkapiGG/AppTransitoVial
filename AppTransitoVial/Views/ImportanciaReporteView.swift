//
//  ImportanciaReporteView.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 18/04/26.
//

import SwiftUI

struct ImportanciaReporteView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.09, blue: 0.13)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 26) {
                        heroCard
                        introSection
                        benefitsSection
                        footerQuote
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 18)
                    .padding(.bottom, 24)
                }

                reportButton
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        ZStack {
            Text("Importancia del Reporte")
                .font(.system(size: 21, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 38, height: 38)
                }
                .buttonStyle(.plain)

                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 14)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.white.opacity(0.08))
                .frame(height: 1)
        }
    }

    private var heroCard: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.12, green: 0.20, blue: 0.33),
                        Color(red: 0.09, green: 0.16, blue: 0.28)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(height: 172)
            .overlay {
                VStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Color.blue.opacity(0.12))
                            .frame(width: 92, height: 72)

                        HStack(spacing: -10) {
                            Image(systemName: "bubble.left.and.bubble.right.fill")
                                .font(.system(size: 28, weight: .semibold))
                            Image(systemName: "heart.fill")
                                .font(.system(size: 22, weight: .bold))
                                .offset(y: -10)
                        }
                        .foregroundStyle(Color(red: 0.27, green: 0.58, blue: 0.99))
                    }

                    Text("Tu voz importa")
                        .font(.system(size: 19, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.27, green: 0.58, blue: 0.99))
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.blue.opacity(0.12), lineWidth: 1)
            )
    }

    private var introSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("¿Por qué reportar?")
                .font(.system(size: 24, weight: .heavy, design: .rounded))
                .foregroundStyle(.white)

            Text("Reportar señales en mal estado ayuda a prevenir accidentes y garantiza que todos lleguen a su destino de forma segura. Tu participación es clave para una ciudad mejor.")
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(Color.white.opacity(0.66))
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var benefitsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("BENEFICIOS CLAVE")
                .font(.system(size: 12, weight: .heavy))
                .tracking(1.2)
                .foregroundStyle(Color.white.opacity(0.32))

            VStack(spacing: 14) {
                BenefitCard(
                    icon: "shield.fill",
                    title: "Mayor seguridad vial",
                    description: "Calles con señales claras son más seguras para peatones y conductores."
                )
                BenefitCard(
                    icon: "exclamationmark.triangle.fill",
                    title: "Reducción de accidentes",
                    description: "Detectar fallas a tiempo previene situaciones de alto riesgo en la vía."
                )
                BenefitCard(
                    icon: "person.2.fill",
                    title: "Participación ciudadana",
                    description: "Tu contribución activa mejora directamente la infraestructura de tu comunidad."
                )
            }
        }
    }

    private var footerQuote: some View {
        Text("“Tu reporte puede salvar vidas”")
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .italic()
            .foregroundStyle(Color.white.opacity(0.28))
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
    }

    private var reportButton: some View {
        Button {
        } label: {
            Text("Comenzar un Reporte")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color(red: 0.27, green: 0.52, blue: 0.92))
                )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 22)
        .padding(.top, 10)
        .padding(.bottom, 14)
        .background(Color(red: 0.06, green: 0.09, blue: 0.13))
    }
}

private struct BenefitCard: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(red: 0.09, green: 0.16, blue: 0.29))
                .frame(width: 42, height: 42)
                .overlay {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color(red: 0.27, green: 0.58, blue: 0.99))
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)

                Text(description)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.58))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.08, green: 0.11, blue: 0.16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )
        )
    }
}

#Preview {
    ImportanciaReporteView()
}
