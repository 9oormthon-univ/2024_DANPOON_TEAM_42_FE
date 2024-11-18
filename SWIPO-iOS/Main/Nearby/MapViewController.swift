//
//  MapViewController.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/18/24.
//

import UIKit
import SnapKit
import KakaoMapsSDK
import CoreLocation

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

class MapViewController: UIViewController, MapControllerDelegate {

    let locationManager = CLLocationManager()
    var longitude = 0.0
    var latitude = 0.0

    private lazy var mapView: KMViewContainer = {
        let view = KMViewContainer()
        return view
    }()

    func addViews() {
        getCurrentLocation()
        let defaultPosition: MapPoint = MapPoint(longitude: longitude, latitude: latitude)
        // 지도(KakaoMap)를 그리기 위한 viewInfo를 생성
        let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 17)

        //KakaoMap 추가.
        DispatchQueue.main.async {
            self.mapController?.addView(mapviewInfo)
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        _observerAdded = false
        _auth = false
        _appear = false
    }

    required init?(coder aDecoder: NSCoder) {
        _observerAdded = false
        _auth = false
        _appear = false
        super.init(coder: aDecoder)
    }

    deinit {
        mapController?.pauseEngine()
        mapController?.resetEngine()

        print("deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapSetupUI()
        mapContainer = mapView
        guard mapContainer != nil else {
            print("맵 생성 실패")
            return
        }

        //KMController 생성.
        mapController = KMController(viewContainer: mapContainer!)
        mapController!.delegate = self

        mapController?.prepareEngine() //엔진 초기화. 엔진 내부 객체 생성 및 초기화가 진행된다.
    }

    override func viewWillAppear(_ animated: Bool) {
        addObservers()
        _appear = true

        if mapController?.isEngineActive == false {
            mapController?.activateEngine()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
    }

    override func viewWillDisappear(_ animated: Bool) {
        _appear = false
        mapController?.pauseEngine()  //렌더링 중지.
    }

    override func viewDidDisappear(_ animated: Bool) {
        removeObservers()
        mapController?.resetEngine()
        //엔진 정지. 추가되었던 ViewBase들이 삭제된다.
    }

    // 인증 실패시 호출.
    func authenticationFailed(_ errorCode: Int, desc: String) {
        print("error code: \(errorCode)")
        print("desc: \(desc)")
        _auth = false
        switch errorCode {
        case 400:
            showToast(self.view, message: "지도 종료(API인증 파라미터 오류)")
            break
        case 401:
            showToast(self.view, message: "지도 종료(API인증 키 오류)")
            break
        case 403:
            showToast(self.view, message: "지도 종료(API인증 권한 오류)")
            break
        case 429:
            showToast(self.view, message: "지도 종료(API 사용쿼터 초과)")
            break
        case 499:
            showToast(self.view, message: "지도 종료(네트워크 오류) 5초 후 재시도..")

            // 인증 실패 delegate 호출 이후 5초뒤에 재인증 시도..
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                print("retry auth...")

                self.mapController?.prepareEngine()
            }
            break
        default:
            break
        }
    }

    // MARK: - auto layout
    private func mapSetupUI() {
        view.backgroundColor = .white

        self.view.addSubview(mapView)

        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    //addView 성공 이벤트 delegate. 추가적으로 수행할 작업을 진행한다.
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        print("OK") //추가 성공. 성공시 추가적으로 수행할 작업을 진행한다.
        createLabelLayer() // 라벨 레이어 생성
        createPoiStyle() // POI 스타일 생성
        createPois() // POI 생성
    }

    //addView 실패 이벤트 delegate. 실패에 대한 오류 처리를 진행한다.
    func addViewFailed(_ viewName: String, viewInfoName: String) {
        print("Failed")
    }

    //Container 뷰가 리사이즈 되었을때 호출된다. 변경된 크기에 맞게 ViewBase들의 크기를 조절할 필요가 있는 경우 여기에서 수행한다.
    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap? = mapController?.getView("mapview") as? KakaoMap
        mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)   //지도뷰의 크기를 리사이즈된 크기로 지정한다.
    }

    func viewWillDestroyed(_ view: ViewBase) {
    }

    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)

        _observerAdded = true
    }

    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)

        _observerAdded = false
    }

    @objc func willResignActive() {
        mapController?.pauseEngine()  //뷰가 inactive 상태로 전환되는 경우 렌더링 중인 경우 렌더링을 중단.
    }

    @objc func didBecomeActive() {
        mapController?.activateEngine() //뷰가 active 상태가 되면 렌더링 시작. 엔진은 미리 시작된 상태여야 함.
    }

    func mapControllerDidChangeZoomLevel(_ mapController: KakaoMapsSDK.KMController, zoomLevel: Double) {
        print("Zoom level changed to: \(zoomLevel)")
    }

    func showToast(_ view: UIView, message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = NSTextAlignment.center
        view.addSubview(toastLabel)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true

        UIView.animate(withDuration: 0.4,
                       delay: duration - 0.4,
                       options: .curveEaseOut,
                       animations: {
            toastLabel.alpha = 0.0
        },
                       completion: { (finished) in
            toastLabel.removeFromSuperview()
        })
    }

    var mapContainer: KMViewContainer?
    var mapController: KMController?
    var _observerAdded: Bool = false
    var _auth: Bool = false
    var _appear: Bool = false

    //Poi생셩을 위한 LabelLayer
    func createLabelLayer() {
        let view = mapController?.getView("mapview") as! KakaoMap
        let manager = view.getLabelManager()
        let layerOption = LabelLayerOptions(layerID: "PoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 0)
        let _ = manager.addLabelLayer(option: layerOption)
    }

    //Poi 표시 스타일 생성
    func createPoiStyle() {
        let view = mapController?.getView("mapview") as! KakaoMap
        let manager = view.getLabelManager()

        // PoiBadge는 스타일에도 추가될 수 있다. 이렇게 추가된 Badge는 해당 스타일이 적용될 때 함께 그려진다.
        let noti1 = PoiBadge(badgeID: "badge1", image: UIImage(systemName: "tooltip"), offset: CGPoint(x: 0.9, y: 0.1), zOrder: 0)
        let iconStyle1 = PoiIconStyle(symbol: UIImage(systemName: "tooltip"), anchorPoint: CGPoint(x: 0.0, y: 0.5), badges: [noti1])
        let poiStyle = PoiStyle(styleID: "PerLevelStyle", styles: [
            PerLevelPoiStyle(iconStyle: iconStyle1, level: 13)
        ])
        manager.addPoiStyle(poiStyle)
    }

    func createPois() {
        let testCoordinates = [
            MapPoint(longitude: 126.9572222, latitude: 37.4963538),
            MapPoint(longitude: 126.9568920135498, latitude: 37.49512014040192),
            MapPoint(longitude: 126.95839405059814, latitude: 37.496771511091566),
            // 추가 좌표를 여기에 입력
        ]

        guard let view = mapController?.getView("mapview") as? KakaoMap else {
            print("KakaoMap 뷰를 가져오지 못했습니다.")
            return
        }

        let manager = view.getLabelManager()
        let layer = manager.getLabelLayer(layerID: "PoiLayer")
        let poiOption = PoiOptions(styleID: "PerLevelStyle")
        poiOption.rank = 0

        for (index, coordinate) in testCoordinates.enumerated() {
            if let poi = layer?.addPoi(option: poiOption, at: coordinate) {
                if let originalImage = UIImage(named: "tooltip") {
                    let resizedImage = originalImage.resize(to: CGSize(width: 60, height: 46))
                    let badge = PoiBadge(badgeID: "noti_\(index)", image: resizedImage, offset: CGPoint(x: 0, y: 0), zOrder: 1)
                    poi.addBadge(badge)
                    poi.show()
                    poi.showBadge(badgeID: "noti_\(index)")
                }
            } else {
                print("Poi 생성 실패 for coordinate: \(coordinate)")
            }
        }
    }

    func getCurrentLocation() {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()

        if let location = manager.location {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            print(latitude)
            print(longitude)
        } else {
            print("위치 정보를 가져올 수 없습니다.")
        }
    }
}
