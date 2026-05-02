//
//  SeguimientoReporteView.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 18/04/26.
//

import SwiftUI

struct SeguimientoReporteView: View {
    @Environment(\.dismiss) private var dismiss
    let report: SubmittedReport
    private let submittedAt = Date()

    private let steps: [ReportStatusStep] = [
        ReportStatusStep(
            title: "Enviado",
            description: "Recibimos tu información correctamente.",
            icon: "checkmark.circle.fill",
            accent: Color(red: 0.35, green: 0.78, blue: 0.45),
            state: .completed
        ),
        ReportStatusStep(
            title: "En revisión",
            description: "Nuestro equipo está validando el desperfecto vial.",
            icon: "clock.fill",
            accent: Color(red: 0.27, green: 0.58, blue: 0.99),
            state: .current
        ),
        ReportStatusStep(
            title: "Atendido",
            description: "Se ha programado la reparación o señalización.",
            icon: "circle.fill",
            accent: Color.white.opacity(0.24),
            state: .pending
        )
    ]

    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.09, blue: 0.13)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        titleSection
                        timelineCard
                        summarySection
                        mapPreview
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 18)
                    .padding(.bottom, 24)
                }

                actionButtons
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        ZStack {
            Text("Seguimiento de Reporte")
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

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Tu reporte está en revisión")
                .font(.system(size: 34 / 2, weight: .heavy, design: .rounded))
                .foregroundStyle(.white)

            Text("ID: #\(report.id.uuidString.prefix(8).uppercased()) · Enviado el \(submittedAt.formatted(date: .abbreviated, time: .omitted))")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.white.opacity(0.48))
        }
    }

    private var timelineCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                ReportTimelineRow(
                    step: step,
                    showsConnector: index < steps.count - 1
                )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.08, green: 0.11, blue: 0.16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )
        )
    }

    private var summarySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Resumen del reporte")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top, spacing: 14) {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white.opacity(report.image == nil ? 0.96 : 0.08))
                        .frame(width: 62, height: 74)
                        .overlay {
                            if let image = report.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 62, height: 74)
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            } else {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundStyle(Color(red: 0.92, green: 0.73, blue: 0.27))
                            }
                        }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("CATEGORÍA")
                            .font(.system(size: 11, weight: .heavy))
                            .tracking(1.1)
                            .foregroundStyle(Color(red: 0.27, green: 0.58, blue: 0.99))

                        Text(report.category)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)

                        Label(report.locationName, systemImage: "location.fill")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color.white.opacity(0.5))
                            .lineLimit(2)
                    }
                }

                Text("“\(report.description)”")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.62))
                    .fixedSize(horizontal: false, vertical: true)

                noteCard
            }
            .padding(12)
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

    private var noteCard: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "info.circle.fill")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color(red: 0.27, green: 0.58, blue: 0.99))

            VStack(alignment: .leading, spacing: 4) {
                Text("Nota de actualización")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.white)

                Text("Tu reporte ha sido asignado a la cuadrilla de mantenimiento zona poniente.")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.white.opacity(0.5))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(red: 0.09, green: 0.16, blue: 0.29))
        )
    }

    private var mapPreview: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.84, green: 0.82, blue: 0.77),
                            Color(red: 0.73, green: 0.79, blue: 0.72)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 112)
                .overlay {
                    ZStack {
                        Path { path in
                            path.move(to: CGPoint(x: 30, y: 10))
                            path.addLine(to: CGPoint(x: 72, y: 82))
                            path.addLine(to: CGPoint(x: 126, y: 124))
                        }
                        .stroke(Color.gray.opacity(0.6), lineWidth: 5)

                        Path { path in
                            path.move(to: CGPoint(x: 170, y: 0))
                            path.addCurve(
                                to: CGPoint(x: 122, y: 120),
                                control1: CGPoint(x: 140, y: 28),
                                control2: CGPoint(x: 182, y: 74)
                            )
                        }
                        .stroke(Color(red: 0.73, green: 0.84, blue: 0.78), lineWidth: 42)

                        Circle()
                            .fill(Color(red: 0.27, green: 0.58, blue: 0.99))
                            .frame(width: 22, height: 22)
                            .overlay(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 8, height: 8)
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color(red: 0.04, green: 0.13, blue: 0.24), lineWidth: 4)
                            )
                            .offset(x: 16, y: -2)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )

            Label(report.locationName, systemImage: "mappin.circle.fill")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Color.white.opacity(0.55))
                .lineLimit(2)
        }
    }

    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button {
            } label: {
                Label("Contactar Soporte", systemImage: "message.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color(red: 0.27, green: 0.52, blue: 0.92))
                    )
            }

            Button {
            } label: {
                Text("Cancelar Reporte")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.white.opacity(0.72))
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 14)
        .background(Color(red: 0.06, green: 0.09, blue: 0.13))
    }
}

private struct ReportTimelineRow: View {
    let step: ReportStatusStep
    let showsConnector: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(step.accent.opacity(step.state == .pending ? 0.14 : 0.2))
                        .frame(width: 22, height: 22)

                    Image(systemName: step.icon)
                        .font(.system(size: step.state == .pending ? 8 : 10, weight: .bold))
                        .foregroundStyle(step.accent)
                }

                if showsConnector {
                    Rectangle()
                        .fill(step.state == .completed ? Color(red: 0.35, green: 0.78, blue: 0.45) : Color.white.opacity(0.08))
                        .frame(width: 2, height: 42)
                }
            }
            .frame(width: 22)

            VStack(alignment: .leading, spacing: 4) {
                Text(step.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(step.titleColor)

                Text(step.description)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(step.descriptionColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding(.vertical, 10)
    }
}

private struct ReportStatusStep: Identifiable {
    enum State {
        case completed
        case current
        case pending
    }

    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let accent: Color
    let state: State

    var titleColor: Color {
        switch state {
        case .completed:
            return .white
        case .current:
            return Color(red: 0.27, green: 0.58, blue: 0.99)
        case .pending:
            return Color.white.opacity(0.4)
        }
    }

    var descriptionColor: Color {
        switch state {
        case .completed:
            return Color.white.opacity(0.52)
        case .current:
            return Color.white.opacity(0.58)
        case .pending:
            return Color.white.opacity(0.24)
        }
    }
}

#Preview {
    SeguimientoReporteView(
        report: SubmittedReport(
            category: "Bache profundo",
            description: "El bache es bastante profundo y se encuentra en el carril central. Representa un riesgo para los motociclistas.",
            locationName: "Av. Paseo de la Reforma 222",
            coordinate: nil,
            image: nil
        )
    )
}
