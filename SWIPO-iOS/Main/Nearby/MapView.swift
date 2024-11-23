//
//  MapView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/18/24.
//

import SwiftUI
import UIKit

struct MapView: UIViewControllerRepresentable {
    @Binding var storeMapResponse: StoreMapResponse?

    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }

    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        if let response = storeMapResponse {
            uiViewController.updateMapData(with: response)
        }
    }
}
