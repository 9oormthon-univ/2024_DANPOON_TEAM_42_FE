//
//  SwipstoneViewModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/20/24.
//

import Foundation
class SwipstoneViewModel: ObservableObject {
    struct State {
        
        //스윕스톤 현황
        var getSwipstoneResponse: [SwipstoneModel] = [SwipstoneModel(id: 0, point: "5,000", collect: false, achieve: false, piece: ["sejong", "gyeongnam"]), SwipstoneModel(id: 1, point: "10,000", collect: false, achieve: false, piece: ["ulsan", "chungcheongnam"]), SwipstoneModel(id: 2, point: "15,000", collect: false, achieve: false, piece: ["gwanju", "jeollanam", "chungcheongnam", "gangwon"])]
        
        var getSwipstonePieceResponse: [SwipstonePieceModel] = [SwipstonePieceModel(id: 0, region: "gyeongnam", count: 1), SwipstonePieceModel(id: 1   , region: "chungcheongnam", count: 2), SwipstonePieceModel(id: 2   , region: "busan", count: 1), SwipstonePieceModel(id: 3   , region: "ulsan", count: 4), SwipstonePieceModel(id: 4   , region: "jeju", count: 1)]
    }
    
    enum Action {
        
    }
    
    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
    }
    
    func action(_ action: Action) async {
        
    }
}

extension SwipstoneViewModel {
    func getUpdatedPieceImage(pieceName: String) -> String {
        // 조각이 있다면 "_blank"를 제거한 이미지 이름 반환
        if state.getSwipstonePieceResponse.contains(where: { $0.region == pieceName }) {
            return pieceName
        }
        // 조각이 없으면 "_blank" 이미지 반환
        return "\(pieceName)_blank"
    }
    // 선택된 카드의 조각들이 모두 현재 소유한 조각에 포함되는지 확인하는 함수
    func containAllPieces(selectedCardIndex: Int) -> Bool {
        // 선택된 카드의 조각 배열 가져오기
        let selectedCardPieces = state.getSwipstoneResponse[selectedCardIndex].piece
        
        // 모든 조각이 `getSwipstonePieceResponse`에 존재하는지 확인
        for piece in selectedCardPieces {
            if !state.getSwipstonePieceResponse.contains(where: { $0.region == piece }) {
                return false // 조각이 하나라도 없으면 false 반환
            }
        }
        //해당 카드 뷰 말풍선 변환을 위해 true로 전환
        state.getSwipstoneResponse[selectedCardIndex].collect = true
        return true // 모든 조각이 존재하면 true 반환
    }
    
    // 추가 포인트 얻기 시 보유하고 있는 조각 회수
    func pieceSubtract(selectedCardIndex: Int) -> Void {
        // 선택된 카드의 조각 배열 가져오기
        let selectedCardPieces = state.getSwipstoneResponse[selectedCardIndex].piece
        
        // 선택된 카드의 조각들을 순회
        for piece in selectedCardPieces {
            // 보유 중인 조각을 찾아서 갯수 차감
            if let index = state.getSwipstonePieceResponse.firstIndex(where: { $0.region == piece }) {
                // 현재 조각의 갯수 감소
                state.getSwipstonePieceResponse[index].count -= 1
                
                // 갯수가 0이 되면 목록에서 삭제
                if state.getSwipstonePieceResponse[index].count <= 0 {
                    state.getSwipstonePieceResponse.remove(at: index)
                }
            }
        }
        //해당 카드 뷰 변환을 위해 true로 전환
        state.getSwipstoneResponse[selectedCardIndex].achieve = true
        state.getSwipstoneResponse[selectedCardIndex].collect = false
    }
}
