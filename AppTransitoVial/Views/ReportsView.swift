//
//  ReportsView.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 12/03/26.
//

import SwiftUI
import PhotosUI
import CoreLocation

struct ReportsView: View {
    
    @State private var selection: String = "Selecciona un tipo de señal"
    @State private var descripcion: String = ""
    @State private var itemSeleccionado: [PhotosPickerItem] = []
    @State private var imagenSeleccionada: [UIImage] = []
    @State private var showHelpView = false
    @State private var selectedLocationName = "Ubicación no seleccionada"
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var submittedReport: SubmittedReport?

    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color.background)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    HStack(spacing: 16) {
                        Button {
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.white)
                        }

                        Text("Reportar una Señal")
                            .font(.title3.weight(.bold))
                            .foregroundStyle(.white)

                        Spacer()

                        Button {
                            showHelpView = true
                        } label: {
                            Text("Ayuda")
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(.blue)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 18)

                    Divider()
                        .overlay(Color.white.opacity(0.08))

                    VStack {
                        Text("Tipo de señal")
                            .foregroundStyle(.white)
                        Menu {
                            Button("Rojo"){ selection = "Rojo" }
                            Button("Amarillo"){ selection = "Amarillo" }
                            Button("Verde"){ selection = "Verde" }
                        } label: {
                            HStack(spacing: 12) {
                                Text(selection)
                                    .foregroundStyle(.white)
                                    .font(.body)
                                    .lineLimit(1)
                                
                                Spacer(minLength: 8)
                                
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                        }
                        .accentColor(.white)
                    }
                    .padding()

                    VStack {
                        Text("Descripción del Problema")
                            .foregroundStyle(.white)
                        
                        ZStack(alignment: .leading) {
                            if descripcion.isEmpty {
                                Text("Describe el daño (ej. grafiti, doblada, etc)...")
                                    .foregroundStyle(Color.white.opacity(0.6))
                                    .padding(.horizontal, 15)
                            }
                            TextField("", text: $descripcion)
                                .foregroundStyle(.white)
                                .tint(.white)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        }
                    }
                    .padding()

                    VStack {
                        Text("Evidencia Visual")
                            .foregroundStyle(.white)
                        
                        HStack(spacing: 40){
                            PhotosPicker(selection: $itemSeleccionado, matching: .images){
                                Rectangle()
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: 150, height: 150)
                                    .overlay(
                                        VStack {
                                            Image(systemName: "camera")
                                                .font(.system(size: 30))
                                                .foregroundColor(.white)
                                                .padding(.bottom, 8)
                                            
                                            Text("Agregar Foto")
                                                .font(.subheadline)
                                                .foregroundStyle(Color.white)
                                        }
                                    )
                            }.cornerRadius(15)
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color.white.opacity(0.1))
                                
                                if let primerImagen = imagenSeleccionada.first {
                                    Image(uiImage: primerImagen)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    VStack(spacing: 8) {
                                        Image(systemName: "photo")
                                            .font(.system(size: 30))
                                            .foregroundColor(.white)
                                            .padding(.bottom, 8)
                                        
                                        Text("Vista previa")
                                            .font(.subheadline)
                                            .foregroundStyle(Color.white)
                                    }
                                }
                            }
                            .frame(width: 150, height: 150)
                            .clipped()
                            .cornerRadius(15)

                        }
                    }
                    .padding()

                    VStack {
                        MapCard(
                            selectedLocationName: $selectedLocationName,
                            selectedCoordinate: $selectedCoordinate
                        )
                            .padding(.bottom, 10)

                        Button {
                            submittedReport = SubmittedReport(
                                category: selection,
                                description: descripcion.isEmpty ? "Sin descripción proporcionada." : descripcion,
                                locationName: selectedLocationName,
                                coordinate: selectedCoordinate,
                                image: imagenSeleccionada.first
                            )
                        } label: {
                            HStack {
                                Text("Enviar Reporte")
                                    .foregroundStyle(Color.white)
                                Image(systemName: "paperplane")
                                    .foregroundStyle(Color.white)
                            }
                        }
                        .padding(10)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationDestination(isPresented: $showHelpView) {
                ImportanciaReporteView()
            }
            .navigationDestination(item: $submittedReport) { report in
                SeguimientoReporteView(report: report)
            }
        }
        .task(id: itemSeleccionado) {
            await cargarImagenSeleccionada()
        }
    }
    
    private func cargarImagenSeleccionada() async {
        var imagenCargada: [UIImage] = []
        for item in itemSeleccionado {
            if let data = try? await item.loadTransferable(type: Data.self),
               let imagen = UIImage(data: data) {
                imagenCargada.append(imagen)
            }
        }
        imagenSeleccionada = imagenCargada
    }
}

struct SubmittedReport: Identifiable, Hashable {
    let id = UUID()
    let category: String
    let description: String
    let locationName: String
    let coordinate: CLLocationCoordinate2D?
    let image: UIImage?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: SubmittedReport, rhs: SubmittedReport) -> Bool {
        lhs.id == rhs.id
    }
}

#Preview {
    ReportsView()
}
