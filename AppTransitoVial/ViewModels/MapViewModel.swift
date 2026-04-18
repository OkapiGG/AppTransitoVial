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
    private let geocoder = CLGeocoder()
    
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
            ubicacion = .region(
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )
            return
        }

        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        currentCoordinate = location.coordinate
        ubicacion = .region(
            MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, _ in
            guard let self else {
                return
            }

            if let placemark = placemarks?.first {
                let street = placemark.thoroughfare
                let number = placemark.subThoroughfare
                let locality = placemark.locality
                let components = [street, number, locality].compactMap { $0 }
                if components.isEmpty {
                    self.currentLocationName = "Lat: \(location.coordinate.latitude.formatted(.number.precision(.fractionLength(4)))), Lon: \(location.coordinate.longitude.formatted(.number.precision(.fractionLength(4))))"
                } else {
                    self.currentLocationName = components.joined(separator: ", ")
                }
            } else {
                self.currentLocationName = "Lat: \(location.coordinate.latitude.formatted(.number.precision(.fractionLength(4)))), Lon: \(location.coordinate.longitude.formatted(.number.precision(.fractionLength(4))))"
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentLocationName = "No fue posible obtener la ubicación"
    }
    
}
