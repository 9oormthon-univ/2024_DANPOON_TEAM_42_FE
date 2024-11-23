//
//  MapViewModel.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation

class MapViewModel: ObservableObject {
    struct State {

    }

    enum Action {
        case getStoreMap(request: StoreMapRequest)
    }

    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
    }
    
    func action(_ action: Action) async {
        switch action {
        case let .getStoreMap(request):
            if let response = await StoreService.getStoreMap(request: request) {
                await MainActor.run {
                    print("\(response.code)")
                }
            } else {
                print("Error")
            }
        }
        
    }
}
