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

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    @Published var ubicacion: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var currentCoordinate: CLLocationCoordinate2D?
    @Published var currentLocationName = "Ubicación no seleccionada"
    
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func pedirPermisoUbicacion(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func seleccionarUbicacionActual() {
        if let coordinate = currentCoordinate {
            ubicacion = .region(region(for: coordinate))
            return
        }

        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        currentCoordinate = location.coordinate
        ubicacion = .region(region(for: location.coordinate))
        
        Task { @MainActor in
            if let request = MKReverseGeocodingRequest(location: location),
               let mapItems = try? await request.mapItems,
               let placemark = mapItems.first?.placemark {
                let street = placemark.thoroughfare
                let number = placemark.subThoroughfare
                let locality = placemark.locality
                let components = [street, number, locality].compactMap { $0 }
                self.currentLocationName = components.isEmpty ? self.formattedCoordinates(for: location.coordinate) : components.joined(separator: ", ")
            } else {
                self.currentLocationName = self.formattedCoordinates(for: location.coordinate)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentLocationName = "No fue posible obtener la ubicación"
    }

    private func region(for coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate, span: defaultSpan)
    }

    private func formattedCoordinates(for coordinate: CLLocationCoordinate2D) -> String {
        let latitude = coordinate.latitude.formatted(.number.precision(.fractionLength(4)))
        let longitude = coordinate.longitude.formatted(.number.precision(.fractionLength(4)))
        return "Lat: \(latitude), Lon: \(longitude)"
    }
    
}
