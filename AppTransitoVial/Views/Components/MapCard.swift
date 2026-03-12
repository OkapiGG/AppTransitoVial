//
//  MapCard.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 12/03/26.
//

import SwiftUI
import MapKit

struct MapCard: View {
    
    @State private var posicion = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 19.3621, longitude: -99.1812),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    )
    
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
                
                
                
                
            }
        }
    }
}

#Preview {
    MapCard()
}
