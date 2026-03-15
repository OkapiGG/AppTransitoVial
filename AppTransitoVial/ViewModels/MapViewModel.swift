//
//  MapaViewModel.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 14/03/26.
//

import Foundation
import MapKit
import SwiftUI
import Combine

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    
    @Published var ubicacion: MapCameraPosition = .userLocation(fallback: .automatic)
    
    override init(){
        super.init()
        locationManager.delegate = self
    }
    
    func pedirPermisoUbicacion(){
        locationManager.requestWhenInUseAuthorization()
    }
    
}
