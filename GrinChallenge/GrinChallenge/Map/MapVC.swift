//
//  MapVC.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/17/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//MARK: - Constantes
struct MapVCConstants {
    static let latitud              = 0.0 //= 19.456444
    static let longitud             = 0.0 //= -99.206988
}

class MapVC: UIViewController , MKMapViewDelegate{

    //MARK: - QRCode
    var scannerViewController: ScannerViewController!
    @IBOutlet weak var referenceTextField: UITextField!

    //MARK: - Parameters
    var locationManager = CLLocationManager()
    var devices : [WSDevice] = []
    var devicesGeoLoc : [String:MKPointAnnotation] = [:]
    var annotationPoints : [MKPointAnnotation] = []
    var annotationViews : [MKAnnotationView] = []
    var latitud = MapVCConstants.latitud
    var longitud = MapVCConstants.longitud
    
    private var annotationViewCurrent : MKAnnotationView? = nil
    var annotationViewSelected : MKAnnotationView?  {
        get {
            return self.annotationViewCurrent
        }
        set {
            if newValue != nil {
                self.showViewDetail(annotation: newValue!)
            } else {
                self.hideViewDetail()
            }
            self.annotationViewCurrent = newValue
        }
    }
    
    //MARK: - @IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var deviceNameLbl: UILabel!
    @IBOutlet weak var deviceAdressLbl: UILabel!
    @IBOutlet weak var deviceStrengthLbl: UILabel!
    @IBOutlet weak var deviceDateCreationLbl: UILabel!
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Delegates
        self.mapView.delegate = self
        self.locationManager.delegate = self
        
        // Config MAP
        self.mapView.mapType = .standard
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
        self.mapView.showsUserLocation = true
        self.initLocation()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch(CLLocationManager.authorizationStatus()) {
        case .notDetermined,.restricted, .denied:
            print("No access")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
            if self.annotationViewSelected == nil{
                self.startLocalization()
            }
        default: break
        }
        
       
    }
    
    //MARK: - Actions
    @IBAction func centerUserLocalization(_ sender: Any) {
        switch(CLLocationManager.authorizationStatus()) {
        case .notDetermined,.restricted, .denied:
            print("No access")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
            startLocalization()
        default: break
        }
    }
    @IBAction func reloadDevices(_ sender: Any) {
        self.getDevices()
    }
    
    //MARK: - ViewDetail
    func showViewDetail(annotation:MKAnnotationView){
        self.viewDetail.isHidden = false
        let deviceGeoLoc = devicesGeoLoc.filter{ $0.value === annotation.annotation}.first
        if deviceGeoLoc != nil{
            let device = self.devices.filter{$0.id == deviceGeoLoc?.key}.first
            if device != nil{
                self.deviceAdressLbl.text = device?.address
                self.deviceDateCreationLbl.text = device?.createdAt
                self.deviceStrengthLbl.text = device?.strength
                self.deviceNameLbl.text = device?.name
            }
        }
    }
    func hideViewDetail(){
        self.viewDetail.isHidden = true
        self.deviceAdressLbl.text = ""
        self.deviceDateCreationLbl.text = ""
        self.deviceStrengthLbl.text = ""
        self.deviceNameLbl.text = ""
    }
    
    func qrCode(){
        scannerViewController = ScannerViewController(nibName: "ScannerViewController", bundle: nil)
        scannerViewController.delegate = self
        self.present(scannerViewController, animated: true, completion: nil)
    }
    
    //MARK: - Funciones Controller
    func initLocation(){
        DispatchQueue.main.async { [weak self] in
            
            guard let customSelf = self else { return }
            
            if CLLocationManager.locationServicesEnabled(){
                // AUTHORIZATION
                switch(CLLocationManager.authorizationStatus()) {
                case .notDetermined:
                    print("Not determined")
                    customSelf.locationManager.requestAlwaysAuthorization() // Ask for Authorisation from the User.
                    customSelf.locationManager.requestWhenInUseAuthorization() // For use in foreground
                case .restricted, .denied:
                    print("No access")
                    customSelf.pedirAuthoDeNuevo()
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                default:
                    break
                }
                
            } else {
                print("Location services are not enabled")
            }
        }
    }
    
    func startLocalization(){
        self.locationManager.startUpdatingLocation()
        if let coor = self.mapView.userLocation.location?.coordinate{
            self.mapView.setCenter(coor, animated: true)
            
            var toBeLoaded = false
            if Double(round(self.latitud * 1000)/1000) - Double(round(coor.latitude * 1000)/1000) >= 0.01 ||
                Double(round(self.longitud * 1000)/1000) - Double(round(coor.longitude * 1000)/1000) >= 0.01   {
                toBeLoaded = true
            }
            
            self.latitud = coor.latitude
            self.longitud = coor.longitude
            
            if toBeLoaded{
                self.getDevices()
            }
        }
    }
    
    func pedirAuthoDeNuevo(){ //Abrir Configuración
        let alertController = UIAlertController(
            title: "Acceso a la Ubicación en Segundo Plano Deshabilitado",
            message: "Para Habilitar la Localización, Abra la Configuración de Esta Aplicación y Establezca el Acceso a la Ubicación a 'Siempre'.",
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Abrir Configuración", style: .default) { (action) in
            if let url = NSURL(string:UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(url as URL)
            }
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }

    //MARK: - WS
    
    func getDevices(){
        // COnfig annotations
        GrinWebServicios.sharedInstance.getDevices(
            verHud: true,
            viewController: self,
            Success:
            { data in
                print(data)
                self.successGetDevices(data: data)
        }, Error: {
            
        })
    }
    
    func successGetDevices(data: [WSDevice]){
        DispatchQueue.main.async { [weak self] in
            
            guard let selfCustom = self else {return }
            
            selfCustom.mapView.removeAnnotations(selfCustom.annotationPoints)
            selfCustom.devicesGeoLoc = [:]
            
            if(data.count == 0){
            }else{
                selfCustom.devices = data
                var i = 1
                for newElement in data{
                    
                    let random = Float(arc4random()) / Float(UInt32.max)
                    let y = Float(i) * random
                    let r : Double = Double( y / 1000)
                    let rlatitud : Double = selfCustom.latitud  + Double((0.001 + r) * Double(cosf(Float(i))))
                    let rlongitud : Double = selfCustom.longitud + Double((0.001 + r) * Double(sinf(Float(i))))
                    
                    
                    let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(rlatitud, rlongitud)
                    let objectAnnotation = MKPointAnnotation()
                    objectAnnotation.title = newElement.strength
                    objectAnnotation.subtitle = newElement.name
                    objectAnnotation.coordinate = pinLocation
                    selfCustom.annotationPoints.append(objectAnnotation)
                    selfCustom.mapView.addAnnotation(objectAnnotation)
                    selfCustom.devicesGeoLoc[newElement.id!] = objectAnnotation
                    
                    i = i + 1
                }
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation === mapView.userLocation {
            return
        }
        
        view.image = UIImage(named : "twotone_phone_iphone_white_48pt")
        view.backgroundColor = UIColor.green
        
        if self.annotationViewSelected != nil {
            self.annotationViewSelected?.image = UIImage(named : "twotone_phone_iphone_black_48pt")
            self.annotationViewSelected?.backgroundColor = nil
        }
        self.annotationViewSelected = view
        let region = MKCoordinateRegion(center: view.annotation!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.annotation === mapView.userLocation {
            return
        }
        
        view.image = UIImage(named : "twotone_phone_iphone_black_48pt")
        view.backgroundColor = nil
        self.annotationViewSelected = nil
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotatonView")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotatonView")
        }
        
        if annotation === mapView.userLocation {
            return nil
        }
        
        annotationView?.image = UIImage(named : "twotone_phone_iphone_black_48pt")
        annotationView?.canShowCallout = true
        
        return annotationView
    }

}
//MARK: - CLocation Delegate
extension MapVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,.authorizedWhenInUse :
            print("Localization Access Granted")
            self.startLocalization()
            break
        case .denied, .notDetermined, .restricted:
            print("Localization Access Denied")
            self.locationManager.requestAlwaysAuthorization() // Ask for Authorisation from the User.
            self.locationManager.requestWhenInUseAuthorization() // For use in foreground
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        if let coordinate = self.locationManager.location?.coordinate{
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self.mapView.setRegion(region, animated: true)
        }

        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        centerMap(locValue)
    }
    
    func centerMap(_ center:CLLocationCoordinate2D){
        print("center map")
        if Double(round(self.latitud * 1000)/1000) - Double(round(center.latitude * 1000)/1000) >= 0.01 ||
            Double(round(self.longitud * 1000)/1000) - Double(round(center.longitude * 1000)/1000) >= 0.01   {
            self.getDevices()
        }
    }
    
}

extension MapVC: ScannerViewControllerDelegate {
    
    func scannerViewControllerDidCapture(barcode: String) {
        let stringValue = barcode
        self.referenceTextField.text = stringValue
    }
    
}

