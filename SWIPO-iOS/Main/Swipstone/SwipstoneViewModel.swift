//
//  SwipstoneViewModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/20/24.
//

import Foundation
class SwipstoneViewModel: ObservableObject {
    struct State {
        // 스윕스톤
        var regionInfo: [RegionInfo] = [RegionInfo(id: 1, region: "서울", slogan: "I·SEOUL·U", imageName: "seoul", unselectedImageName: "unselected_seoul"),
                                        RegionInfo(id: 2, region: "경남", slogan: "경남, 새로운 미래로", imageName: "gyeongnam", unselectedImageName: "unselected_gyeongnam"),
                                        RegionInfo(id: 3, region: "경기", slogan: "공정, 평화, 번영의 경기도", imageName: "gyeonggi", unselectedImageName: "unselected_gyeonggi"),
                                        RegionInfo(id: 4, region: "인천", slogan: "All Ways Incheon", imageName: "incheon", unselectedImageName: "unselected_incheon"),
                                        RegionInfo(id: 5, region: "강원", slogan: "강원, 웰니스", imageName: "gangwon", unselectedImageName: "unselected_gangwon"),
                                        RegionInfo(id: 6, region: "충남", slogan: "힘쎈 충남", imageName: "chungcheongnam", unselectedImageName: "unselected_chungcheongnam"),
                                        RegionInfo(id: 7, region: "대전", slogan: "대전은 과학입니다", imageName: "daejeon", unselectedImageName: "unselected_daejeon"),
                                        RegionInfo(id: 8, region: "충북", slogan: "충북, 바이오 미래로", imageName: "chungcheongbuk", unselectedImageName: "unselected_chungcheongbuk"),
                                        RegionInfo(id: 9, region: "세종", slogan: "세종, 스마트 행복도시", imageName: "sejong", unselectedImageName: "unselected_sejong"),
                                        RegionInfo(id: 10, region: "부산", slogan: "Dynamic Busan", imageName: "busan", unselectedImageName: "unselected_busan"),
                                        RegionInfo(id: 11, region: "울산", slogan: "울산, 친환경 미래도시", imageName: "ulsan", unselectedImageName: "unselected_ulsan"),
                                        RegionInfo(id: 12, region: "대구", slogan: "Colorful Daegu", imageName: "daegu", unselectedImageName: "unselected_daegu"),
                                        RegionInfo(id: 13, region: "경북", slogan: "새바람 행복경북", imageName: "gyeongsangbuk", unselectedImageName: "unselected_gyeongsangbuk"),
                                        RegionInfo(id: 14, region: "전남", slogan: "청정 전남 블루 이코노미", imageName: "jeollanam", unselectedImageName: "unselected_jeollanam"),
                                        RegionInfo(id: 15, region: "광주", slogan: "정의로운 도시, 광주", imageName: "gwanju", unselectedImageName: "unselected_gwanju"),
                                        RegionInfo(id: 16, region: "전북", slogan: "천년 전북, 새로운 도약", imageName: "jeollabuk", unselectedImageName: "unselected_jeollabuk"),
                                        RegionInfo(id: 76, region: "제주", slogan: "제주, 지속 가능한 미래", imageName: "jeju", unselectedImageName: "unselected_jeju")]
        
        //스윕스톤 현황
        var getSwipstoneResponse: [SwipstoneModel] = [SwipstoneModel(id: 0, point: "5000", collect: false, achieve: false, piece: ["sejong", "gyeongnam"], achievedPieces: []), SwipstoneModel(id: 1, point: "10000", collect: false, achieve: false, piece: ["ulsan", "chungcheongnam"], achievedPieces: []), SwipstoneModel(id: 2, point: "15000", collect: false, achieve: false, piece: ["gwanju", "jeollanam", "chungcheongnam", "gangwon"], achievedPieces: [])]
        
        var getSwipstonePieceResponse: [SwipstonePieceCountModel] = []
        var getSwipstonePieceSubResponse: [PieceModel] = []
    }
    
    enum Action {
        case getSwipstonePiece
        case subtractPiece(usedPieceInfo: UsedPieceInfo)
    }
    
    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
        
        for index in 0..<state.getSwipstoneResponse.count {
            let key = "achieve_status_\(state.getSwipstoneResponse[index].id)"
            //KeyChainManager.deleteItem(key: key)
            if KeyChainManager.readItem(key: key) == "true" {
                self.state.getSwipstoneResponse[index].achieve  = true
                self.state.getSwipstoneResponse[index].collect = false
            }
        }
        
        // 초기화 상태 로그 출력
        for card in state.getSwipstoneResponse {
            print("카드 ID: \(card.id), achieve 상태: \(card.achieve)")
        }
           
    }
    
    func action(_ action: Action) async {
        switch action {
        case let .getSwipstonePiece:
            if let response = await SwipstoneService.getSwipstonePiece() {
                print(response)
                await MainActor.run {
                    print("\(response.code)")
                    
                    if let reponseData = response.data {
                        updateSwipstonePieces(with: reponseData)
                        state.getSwipstonePieceSubResponse = reponseData.pieces
                        
                        for index in   0...2{
                            containAllPieces(selectedCardIndex: index)
                        }
                        
                    } else {
                        print("Error")
                    }
                }
            } else {
                print("Error")
            }
        case let .subtractPiece(usedPieceInfo):
            if let response = await SwipstoneService.subtractPiece(usedPieceInfo: usedPieceInfo) {
                print(response)
                await MainActor.run {
                    print("\(response.code)")
                }
            } else {
                print("Error")
            }

        }
    }
}

extension SwipstoneViewModel {
    func updateSwipstonePieces(with recentPieces: SwipstonePieceModel) {
        // 초기화
        var pieceCountDict: [String: Int] = [:]
        
        // 조각 데이터를 이름별로 그룹화하여 카운트
        for piece in recentPieces.pieces {
            pieceCountDict[piece.pieceName, default: 0] += 1
        }
        
        // Dictionary를 모델 배열로 변환
        state.getSwipstonePieceResponse = pieceCountDict.map { key, value in
            SwipstonePieceCountModel(region: key, count: value)
        }
        
        print("Swipstone pieces updated: \(state.getSwipstonePieceResponse)")
    }
    
    func getUpdatedPieceImage(cardIndex: Int, pieceName: String) -> String {
        let card = state.getSwipstoneResponse[cardIndex]
        
        // 카드가 `achieve` 상태라면, `achievedPieces`를 참조
        if card.achieve{
            return pieceName
        }
//        if card.achieve, let achievedPieces = card.achievedPieces {
//            if achievedPieces.contains(pieceName) {
//                return pieceName
//            }
//        }
        
        // 조각이 실제로 있다면 "_blank"를 제거한 이미지 이름 반환
        if state.getSwipstonePieceResponse.contains(where: { $0.region == pieceName }) {
            return pieceName
        }
        
        // 조각이 없으면 "_blank" 이미지 반환
        return "\(pieceName)_blank"
    }
    
    func containAllPieces(selectedCardIndex: Int) -> Bool {
        // 선택된 카드의 조각 배열 가져오기
        let selectedCardPieces = state.getSwipstoneResponse[selectedCardIndex].piece
        
        // 모든 조각이 `getSwipstonePieceResponse`에 존재하는지 확인
        for piece in selectedCardPieces {
            if !state.getSwipstonePieceResponse.contains(where: { $0.region == piece && $0.count > 0 }) {
                state.getSwipstoneResponse[selectedCardIndex].collect = false
                return false // 조각이 하나라도 없으면 false 반환
            }
        }
        // 해당 카드 뷰 말풍선 변환을 위해 true로 전환
        state.getSwipstoneResponse[selectedCardIndex].collect = true
        return true // 모든 조각이 존재하면 true 반환
    }
    
//    func pieceSubtract(selectedCardIndex: Int) {
//        // 선택된 카드의 조각 배열 가져오기
//        let selectedCardPieces = state.getSwipstoneResponse[selectedCardIndex].piece
//        
//        // 카드가 `achieve` 상태로 변경될 때, 조각 스냅샷 저장
//        state.getSwipstoneResponse[selectedCardIndex].achievedPieces = selectedCardPieces
//        
//        // 선택된 카드의 조각들을 순회하며 실제 보유 조각 갯수 차감
//        for piece in selectedCardPieces {
//            if let index = state.getSwipstonePieceResponse.firstIndex(where: { $0.region == piece }) {
//                state.getSwipstonePieceResponse[index].count -= 1
//                
//                // 갯수가 0이면 목록에서 삭제
//                if state.getSwipstonePieceResponse[index].count <= 0 {
//                    state.getSwipstonePieceResponse.remove(at: index)
//                }
//            }
//        }
//        
//        let key = "achieve_status_\(state.getSwipstoneResponse[selectedCardIndex].id)"
//        KeyChainManager.addItem(key: key, value: "true")
//        
//        // 카드 상태 업데이트
//        state.getSwipstoneResponse[selectedCardIndex].achieve = true
//        for index in 0..<state.getSwipstoneResponse.count {
//            _ = containAllPieces(selectedCardIndex: index)
//        }
//    }
    func pieceSubtract(selectedCardIndex: Int) -> UsedPieceInfo {
        let selectedCardPieces = state.getSwipstoneResponse[selectedCardIndex].piece
        var usedPieceIds: [String] = []

        // 선택된 조각의 갯수를 차감하며 ID를 수집
        for piece in selectedCardPieces {
            if let index = state.getSwipstonePieceResponse.firstIndex(where: { $0.region == piece }) {
                state.getSwipstonePieceResponse[index].count -= 1

                // ID가 있다면 수집
                if let pieceId = state.getSwipstonePieceSubResponse.first(where: { $0.pieceName == piece })?.myPieceId {
                    usedPieceIds.append(pieceId)
                }

                // 갯수가 0이면 목록에서 삭제
                if state.getSwipstonePieceResponse[index].count <= 0 {
                    state.getSwipstonePieceResponse.remove(at: index)
                }
            }
        }

        let key = "achieve_status_\(state.getSwipstoneResponse[selectedCardIndex].id)"
        KeyChainManager.addItem(key: key, value: "true")
        
        // 카드 상태 업데이트
        state.getSwipstoneResponse[selectedCardIndex].achieve = true
        for index in 0..<state.getSwipstoneResponse.count {
            _ = containAllPieces(selectedCardIndex: index)
        }
        
        // 사용된 데이터 생성
        let usedPieceInfo = UsedPieceInfo(
            point: Int(state.getSwipstoneResponse[selectedCardIndex].point) ?? 0,
            usePieceNum: Int(usedPieceIds.count),
            myPieceIds: usedPieceIds
        )
        return usedPieceInfo
    }
    
    
}
