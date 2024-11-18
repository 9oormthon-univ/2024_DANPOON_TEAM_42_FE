//
//  GeoServiceManager.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import Foundation
import CoreLocation

final class GeoServiceManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager: CLLocationManager!
    var onLocationUpdate: ((CLLocation) -> Void)?
    var onAddressUpdate: ((String) -> Void)? // 주소 업데이트 클로저
    @Published var showAlert = false
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() throws {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            objectWillChange.send() // 상태 변화 알림 추가
            showAlert = true
            throw GeoError.accessRestricted
        case .denied:
            objectWillChange.send() // 상태 변화 알림 추가
            showAlert = true
            throw GeoError.accessDenied
        case .authorized, .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 권한이 있을 때 즉시 위치 업데이트 시작
        @unknown default:
            objectWillChange.send() // 상태 변화 알림 추가
            showAlert = true
            throw GeoError.accessDenied
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation() // 위치 업데이트 중단

        // 위치를 주소로 변환하여 onAddressUpdate 클로저에 전달
        convertToAddress { addressResult in
            self.onAddressUpdate?(addressResult)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation() // 권한이 허용되면 위치 업데이트 시작
        } else if status == .denied {
            objectWillChange.send() // 상태 변화 알림 추가
            showAlert = true // 권한이 거부되면 showAlert를 true로 설정
        }
    }
    
    func loadCurrentUserRoadAddress() async throws -> String {
        let geoCoder = CLGeocoder()
        guard let location = locationManager.location else {
            throw GeoError.canNotFound
        }
        let places = try await geoCoder.reverseGeocodeLocation(location)
        guard let place = places.last,
              let sido = place.administrativeArea else {
            throw GeoError.canNotFound
        }
        return "\(sido)"
    }
    
    func convertToAddress(completion: @escaping (String) -> Void) {
        Task {
            do {
                let address = try await loadCurrentUserRoadAddress()
                completion(address)
            } catch {
                completion("주소를 가져올 수 없습니다.")
            }
        }
    }
}

enum GeoError: Error {
    case accessRestricted
    case accessDenied
    case canNotFound
}


