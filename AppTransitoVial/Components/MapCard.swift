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
    
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Text("Ubicación del incidente")
                        .font(.headline)
                        .foregroundColor(.white)
                                
                    Spacer()
                                
                    Button(action: {
                        
                    }) {
                        Label("Mi ubicación", systemImage: "mappin.and.ellipse")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        }
                    
                }.padding(.horizontal)
                
                Map(position: $ubicacion.ubicacion){
                    UserAnnotation()
                }.mapControls{
                    MapUserLocationButton()
                }.onAppear {
                    ubicacion.pedirPermisoUbicacion()
                }
                .frame(height: 200)
            }
        }
    }
}

#Preview {
    MapCard()
}
