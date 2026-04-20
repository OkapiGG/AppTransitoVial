//
//  MapCard.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 12/03/26.
//

import SwiftUI
import MapKit

struct MapCard: View {
    
    @StateObject private var ubicacion = MapViewModel()
    @Binding var selectedLocationName: String
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Text("Ubicación del incidente")
                        .font(.headline)
                        .foregroundColor(.white)
                                
                    Spacer()
                                
                    Button(action: {
                        ubicacion.seleccionarUbicacionActual()
                        selectedLocationName = ubicacion.currentLocationName
                        selectedCoordinate = ubicacion.currentCoordinate
                    }) {
                        Label("Mi ubicación", systemImage: "mappin.and.ellipse")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        }
                    
                }.padding(.horizontal)

                HStack {
                    Text(selectedLocationName)
                        .font(.caption)
                        .foregroundStyle(Color.white.opacity(0.7))
                        .lineLimit(2)

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                Map(position: $ubicacion.ubicacion){
                    UserAnnotation()
                }.mapControls{
                    MapUserLocationButton()
                }.onAppear {
                    ubicacion.pedirPermisoUbicacion()
                }
                .onReceive(ubicacion.$currentLocationName) { value in
                    if selectedLocationName == "Ubicación no seleccionada" || selectedLocationName == "No fue posible obtener la ubicación" {
                        selectedLocationName = value
                    }
                }
                .onReceive(ubicacion.$currentCoordinate) { coordinate in
                    if selectedCoordinate == nil {
                        selectedCoordinate = coordinate
                    }
                }
                .frame(height: 200)
            }
        }
    }
}

#Preview {
    MapCard(selectedLocationName: .constant("Ubicación no seleccionada"), selectedCoordinate: .constant(nil))
}
