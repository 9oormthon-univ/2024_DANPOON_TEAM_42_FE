//
//  CustomViewModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/23/24.
//

import Foundation
class CustomViewModel: ObservableObject {
    struct State {
    
    }
    
    enum Action {
        case registerCard(region: String, custom_image: String, multipartFile: [Foundation.Data?])
    }
    
    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
    }
    
    func action(_ action: Action) async {
        switch action {
        case let .registerCard(region, custom_image, multipartFile):
            if let response = await CustomService.registerCard(region: region, custom_image: custom_image, multipartFile: multipartFile) {
                await MainActor.run {
                    print("\(response.code)")

                }
            } else {
                print("Error")
            }
        }
        
    }
}
