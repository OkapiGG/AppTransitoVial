//
//  CatalogoSenalViewModel.swift
//  AppTransitoVial
//
//  Created by Codex on 18/04/26.
//

import SwiftUI
import Combine

final class CatalogoSenalViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedCategory: SignalCatalogFilter = .all

    let sections: [SignalCatalogSection] = [
        SignalCatalogSection(
            title: "Reglamentarias",
            description: "Establecen obligaciones, prohibiciones o limitaciones que deben cumplirse en la circulacion.",
            accent: Color(red: 0.92, green: 0.33, blue: 0.28),
            filter: .reglamentarias,
            signals: [
                SignalCatalogItem(title: "Alto", description: "Obligatorio detenerse por completo antes de continuar.", icon: "stop.fill", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "Ceda el paso", description: "Debes dar prioridad a los vehiculos que circulan primero.", icon: "triangle.fill", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "Limite de velocidad", description: "Indica la velocidad maxima permitida en el tramo.", icon: "gauge.with.dots.needle.33percent", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "No entrar", description: "Prohibe el acceso a vehiculos en ese sentido.", icon: "xmark.circle.fill", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "No estacionarse", description: "Impide aparcar en la zona señalada.", icon: "parkingsign.circle.fill", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "No rebasar", description: "Prohibe adelantar a otros vehiculos en el tramo.", icon: "car.rear.road.lane.dashed", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "Vuelta izquierda prohibida", description: "No se permite girar a la izquierda en la interseccion.", icon: "arrow.turn.up.left.circle.fill", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "Vuelta derecha prohibida", description: "No se permite girar a la derecha en la interseccion.", icon: "arrow.turn.up.right.circle.fill", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "Retorno prohibido", description: "Restringe realizar vueltas en U.", icon: "arrow.uturn.backward.circle.fill", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "Sentido unico", description: "Indica que la circulacion solo va en una direccion.", icon: "arrow.right.circle.fill", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "Uso obligatorio de cinturon", description: "Recuerda el uso obligatorio del cinturon de seguridad.", icon: "figure.seated.side.air.upper", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias),
                SignalCatalogItem(title: "Velocidad minima", description: "Establece la velocidad minima permitida en la via.", icon: "gauge.low", accent: Color(red: 0.92, green: 0.33, blue: 0.28), kind: .reglamentarias)
            ]
        ),
        SignalCatalogSection(
            title: "Preventivas",
            description: "Alertan sobre curvas, cruces, zonas escolares o condiciones que requieren precaucion.",
            accent: Color(red: 0.90, green: 0.68, blue: 0.24),
            filter: .preventivas,
            signals: [
                SignalCatalogItem(title: "Curva peligrosa", description: "Advierte un cambio brusco de direccion en la via.", icon: "arrow.turn.up.right", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Cruce peatonal", description: "Indica una zona frecuentada por peatones.", icon: "figure.walk", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Zona escolar", description: "Pide reducir velocidad por presencia de estudiantes.", icon: "graduationcap.fill", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Semaforo adelante", description: "Advierte la proximidad de un semaforo.", icon: "trafficlight.fill", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Cruce de ferrocarril", description: "Anuncia la cercania de una via ferrea.", icon: "tram.fill", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Doble curva", description: "Se aproxima una serie de curvas consecutivas.", icon: "arrow.left.and.right.righttriangle.left.righttriangle.right.fill", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Reduccion de carril", description: "La via pierde uno de sus carriles mas adelante.", icon: "arrow.left.arrow.right", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Glorieta", description: "Avisa la presencia de una rotonda o glorieta.", icon: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Pendiente peligrosa", description: "Advierte una bajada o subida pronunciada.", icon: "mountain.2.fill", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Obras en la via", description: "Se realizan trabajos sobre la carretera o calle.", icon: "cone.fill", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Pavimento resbaladizo", description: "Existe riesgo de derrape por superficie deslizante.", icon: "car.side.fill", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Interseccion en T", description: "La via termina o conecta con otra formando una T.", icon: "t.square.fill", accent: Color(red: 0.90, green: 0.68, blue: 0.24), kind: .preventivas, diamond: true)
            ]
        ),
        SignalCatalogSection(
            title: "Informativas",
            description: "Brindan orientacion sobre servicios, destinos, ubicaciones y apoyo al conductor.",
            accent: Color(red: 0.28, green: 0.56, blue: 0.96),
            filter: .informativas,
            signals: [
                SignalCatalogItem(title: "Hospital", description: "Señala cercania de servicios medicos.", icon: "cross.case.fill", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas),
                SignalCatalogItem(title: "Gasolinera", description: "Identifica un punto de abastecimiento de combustible.", icon: "fuelpump.fill", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas),
                SignalCatalogItem(title: "Estacionamiento", description: "Marca un area autorizada para aparcar.", icon: "parkingsign", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas),
                SignalCatalogItem(title: "Telefono", description: "Indica un punto de telefono de emergencia o servicio.", icon: "phone.fill", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas),
                SignalCatalogItem(title: "Restaurante", description: "Señala la presencia de alimentos o servicio de comida.", icon: "fork.knife", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas),
                SignalCatalogItem(title: "Sanitarios", description: "Indica la disponibilidad de baños o servicios sanitarios.", icon: "figure.stand", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas),
                SignalCatalogItem(title: "Hotel", description: "Marca hospedaje o zona de alojamiento cercana.", icon: "bed.double.fill", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas),
                SignalCatalogItem(title: "Taller mecanico", description: "Señala servicio de reparacion para vehiculos.", icon: "wrench.and.screwdriver.fill", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas),
                SignalCatalogItem(title: "Aeropuerto", description: "Indica direccion o cercania de una terminal aerea.", icon: "airplane", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas),
                SignalCatalogItem(title: "Terminal de autobuses", description: "Guia hacia una central o parada de autobuses.", icon: "bus.fill", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas),
                SignalCatalogItem(title: "Policia", description: "Indica una estacion o modulo de seguridad publica.", icon: "shield.lefthalf.filled", accent: Color(red: 0.28, green: 0.56, blue: 0.96), kind: .informativas)
            ]
        )
    ]

    var visibleSections: [SignalCatalogSection] {
        if selectedCategory == .all {
            let allSignals = sections
                .flatMap { $0.signals }
                .filter(matchesSearch)

            guard !allSignals.isEmpty else {
                return []
            }

            return [
                SignalCatalogSection(
                    title: "Todas las señales",
                    description: "Consulta en un solo lugar las señales reglamentarias, preventivas e informativas mas comunes.",
                    accent: Color(red: 0.27, green: 0.58, blue: 0.99),
                    filter: .all,
                    signals: allSignals
                )
            ]
        }

        return sections.compactMap { section in
            guard selectedCategory == section.filter else {
                return nil
            }

            let filteredSignals = section.signals.filter(matchesSearch)
            guard !filteredSignals.isEmpty else {
                return nil
            }

            return SignalCatalogSection(
                title: section.title,
                description: section.description,
                accent: section.accent,
                filter: section.filter,
                signals: filteredSignals
            )
        }
    }

    private func matchesSearch(_ signal: SignalCatalogItem) -> Bool {
        searchText.isEmpty ||
        signal.title.localizedCaseInsensitiveContains(searchText) ||
        signal.description.localizedCaseInsensitiveContains(searchText)
    }
}

struct SignalCatalogSection: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let accent: Color
    let filter: SignalCatalogFilter
    let signals: [SignalCatalogItem]
}

struct SignalCatalogItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let accent: Color
    let kind: SignalCatalogFilter
    var diamond: Bool = false

    var classificationText: String {
        if kind == .informativas {
            return "Señal informativa"
        }
        if kind == .preventivas {
            return "Señal preventiva"
        }
        return "Señal reglamentaria"
    }
}

enum SignalCatalogFilter: String, CaseIterable, Identifiable {
    case all
    case reglamentarias
    case preventivas
    case informativas

    var id: String { rawValue }

    var title: String {
        switch self {
        case .all:
            return "Todas"
        case .reglamentarias:
            return "Reglamentarias"
        case .preventivas:
            return "Preventivas"
        case .informativas:
            return "Informativas"
        }
    }

    var icon: String? {
        switch self {
        case .all:
            return nil
        case .reglamentarias:
            return "hand.raised.fill"
        case .preventivas:
            return "exclamationmark.triangle.fill"
        case .informativas:
            return "info.circle.fill"
        }
    }

    var activeColor: Color {
        switch self {
        case .all:
            return Color(red: 0.27, green: 0.58, blue: 0.99)
        case .reglamentarias:
            return Color(red: 0.92, green: 0.33, blue: 0.28)
        case .preventivas:
            return Color(red: 0.90, green: 0.68, blue: 0.24)
        case .informativas:
            return Color(red: 0.28, green: 0.56, blue: 0.96)
        }
    }
}
