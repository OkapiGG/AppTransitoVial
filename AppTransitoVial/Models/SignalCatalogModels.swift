//
//  SignalCatalogModels.swift
//  AppTransitoVial
//
//  Created by Codex on 30/04/26.
//

import SwiftUI

struct SignalCatalogSection: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let accent: Color
    let filter: SignalCatalogFilter
    let signals: [SignalCatalogItem]

    static let allSections: [SignalCatalogSection] = [
        SignalCatalogSection(
            title: "Reglamentarias",
            description: "Establecen obligaciones, prohibiciones o limitaciones que deben cumplirse en la circulacion.",
            accent: .catalogReglamentary,
            filter: .reglamentarias,
            signals: [
                SignalCatalogItem(title: "Alto", description: "Obligatorio detenerse por completo antes de continuar.", icon: "alto", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "Ceda el paso", description: "Debes dar prioridad a los vehiculos que circulan primero.", icon: "cedaElPaso", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "Limite de velocidad", description: "Indica la velocidad maxima permitida en el tramo.", icon: "limiteVelocidad", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "No entrar", description: "Prohibe el acceso a vehiculos en ese sentido.", icon: "noEntrar", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "No estacionarse", description: "Impide aparcar en la zona señalada.", icon: "noEstacionar", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "No rebasar", description: "Prohibe adelantar a otros vehiculos en el tramo.", icon: "noRebasar", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "Vuelta izquierda prohibida", description: "No se permite girar a la izquierda en la interseccion.", icon: "vueltaIzqProhibida", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "Vuelta derecha prohibida", description: "No se permite girar a la derecha en la interseccion.", icon: "vueltaDerProhibida", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "Retorno prohibido", description: "Restringe realizar vueltas en U.", icon: "retornoProhibido", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "Sentido unico", description: "Indica que la circulacion solo va en una direccion.", icon: "sentidoUnico", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "Uso obligatorio de cinturon", description: "Recuerda el uso obligatorio del cinturon de seguridad.", icon: "usoCinturon", accent: .catalogReglamentary, kind: .reglamentarias),
                SignalCatalogItem(title: "Velocidad minima", description: "Establece la velocidad minima permitida en la via.", icon: "velocidadMinima", accent: .catalogReglamentary, kind: .reglamentarias)
            ]
        ),
        SignalCatalogSection(
            title: "Preventivas",
            description: "Alertan sobre curvas, cruces, zonas escolares o condiciones que requieren precaucion.",
            accent: .catalogPreventive,
            filter: .preventivas,
            signals: [
                SignalCatalogItem(title: "Curva peligrosa", description: "Advierte un cambio brusco de direccion en la via.", icon: "curvaPeligrosa", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Cruce peatonal", description: "Indica una zona frecuentada por peatones.", icon: "crucePeatonal", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Zona escolar", description: "Pide reducir velocidad por presencia de estudiantes.", icon: "zonaEscolar", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Semaforo adelante", description: "Advierte la proximidad de un semaforo.", icon: "semaforo", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Cruce de ferrocarril", description: "Anuncia la cercania de una via ferrea.", icon: "cruceFerrocarril", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Doble curva", description: "Se aproxima una serie de curvas consecutivas.", icon: "dobleCurva", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Reduccion de carril", description: "La via pierde uno de sus carriles mas adelante.", icon: "arrow.left.arrow.right", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Glorieta", description: "Avisa la presencia de una rotonda o glorieta.", icon: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Pendiente peligrosa", description: "Advierte una bajada o subida pronunciada.", icon: "mountain.2.fill", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Obras en la via", description: "Se realizan trabajos sobre la carretera o calle.", icon: "cone.fill", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Pavimento resbaladizo", description: "Existe riesgo de derrape por superficie deslizante.", icon: "car.side.fill", accent: .catalogPreventive, kind: .preventivas, diamond: true),
                SignalCatalogItem(title: "Interseccion en T", description: "La via termina o conecta con otra formando una T.", icon: "t.square.fill", accent: .catalogPreventive, kind: .preventivas, diamond: true)
            ]
        ),
        SignalCatalogSection(
            title: "Informativas",
            description: "Brindan orientacion sobre servicios, destinos, ubicaciones y apoyo al conductor.",
            accent: .catalogInformative,
            filter: .informativas,
            signals: [
                SignalCatalogItem(title: "Hospital", description: "Señala cercania de servicios medicos.", icon: "cross.case.fill", accent: .catalogInformative, kind: .informativas),
                SignalCatalogItem(title: "Gasolinera", description: "Identifica un punto de abastecimiento de combustible.", icon: "fuelpump.fill", accent: .catalogInformative, kind: .informativas),
                SignalCatalogItem(title: "Estacionamiento", description: "Marca un area autorizada para aparcar.", icon: "parkingsign", accent: .catalogInformative, kind: .informativas),
                SignalCatalogItem(title: "Telefono", description: "Indica un punto de telefono de emergencia o servicio.", icon: "phone.fill", accent: .catalogInformative, kind: .informativas),
                SignalCatalogItem(title: "Restaurante", description: "Señala la presencia de alimentos o servicio de comida.", icon: "fork.knife", accent: .catalogInformative, kind: .informativas),
                SignalCatalogItem(title: "Sanitarios", description: "Indica la disponibilidad de baños o servicios sanitarios.", icon: "figure.stand", accent: .catalogInformative, kind: .informativas),
                SignalCatalogItem(title: "Hotel", description: "Marca hospedaje o zona de alojamiento cercana.", icon: "bed.double.fill", accent: .catalogInformative, kind: .informativas),
                SignalCatalogItem(title: "Taller mecanico", description: "Señala servicio de reparacion para vehiculos.", icon: "wrench.and.screwdriver.fill", accent: .catalogInformative, kind: .informativas),
                SignalCatalogItem(title: "Aeropuerto", description: "Indica direccion o cercania de una terminal aerea.", icon: "airplane", accent: .catalogInformative, kind: .informativas),
                SignalCatalogItem(title: "Terminal de autobuses", description: "Guia hacia una central o parada de autobuses.", icon: "bus.fill", accent: .catalogInformative, kind: .informativas),
                SignalCatalogItem(title: "Policia", description: "Indica una estacion o modulo de seguridad publica.", icon: "shield.lefthalf.filled", accent: .catalogInformative, kind: .informativas)
            ]
        )
    ]

    static let allSignalsSection = SignalCatalogSection(
        title: "Todas las señales",
        description: "Consulta en un solo lugar las señales reglamentarias, preventivas e informativas mas comunes.",
        accent: .catalogAll,
        filter: .all,
        signals: []
    )
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
        switch kind {
        case .informativas:
            return "Señal informativa"
        case .preventivas:
            return "Señal preventiva"
        default:
            return "Señal reglamentaria"
        }
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
            return .catalogAll
        case .reglamentarias:
            return .catalogReglamentary
        case .preventivas:
            return .catalogPreventive
        case .informativas:
            return .catalogInformative
        }
    }
}

private extension Color {
    static let catalogAll = Color(red: 0.27, green: 0.58, blue: 0.99)
    static let catalogReglamentary = Color(red: 0.92, green: 0.33, blue: 0.28)
    static let catalogPreventive = Color(red: 0.90, green: 0.68, blue: 0.24)
    static let catalogInformative = Color(red: 0.28, green: 0.56, blue: 0.96)
}
