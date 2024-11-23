import Foundation
struct SwipstoneService {
    
    //accessToken 재발급
    static func getSwipstonePiece() async -> BaseResponse<SwipstonePieceModel>? {
        return await NetworkManager.shared.request(SwipstoneEndPoint.getSwipstonePiece)
    }
    
    // 스윕스톤 피스 차감
    static func subtractPiece(usedPieceInfo: UsedPieceInfo) async -> BaseResponse<SubtractPieceModel>? {
        return await NetworkManager.shared.request(SwipstoneEndPoint.subtractPiece(point: usedPieceInfo.point,usePieceNum: usedPieceInfo.usePieceNum,myPieceIds: usedPieceInfo.myPieceIds))
    }
}
