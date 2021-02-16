//
//  LocationViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 21/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: BaseViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
 
    
    public static var lat:Double = 0.0
    public static var lng:Double = 0.0
    public static var address:String = ""
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    override func addrightBtnToNavigationBar() {
        self.rightBarButton =  UIBarButtonItem(image:UIImage(systemName: "mappin.and.ellipse"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionPin))
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionPin()  {
        
            self.mapThis(destinationCor: CLLocationCoordinate2D(latitude: LocationViewController.lat, longitude:LocationViewController.lng))
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func mapThis(destinationCor : CLLocationCoordinate2D ){
        let sourceCoordinates = (locationManager.location?.coordinate)!
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinates)
        let desPlaceMark = MKPlacemark(coordinate: destinationCor)
        
        let annotationSource = MKPointAnnotation()
        annotationSource.coordinate = sourceCoordinates
        annotationSource.title = "My Current Location"
        self.mapView.addAnnotation(annotationSource)
        
        let annotationDes = MKPointAnnotation()
        annotationDes.coordinate = destinationCor
        annotationDes.title = LocationViewController.address
        
        self.mapView.addAnnotation(annotationDes)
        
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let desItem = MKMapItem(placemark: desPlaceMark)
        
        let destinationReq = MKDirections.Request()
        destinationReq.source = sourceItem
        destinationReq.destination = desItem
        destinationReq.transportType = .automobile
        destinationReq.requestsAlternateRoutes = true
        
        
        let region = MKCoordinateRegion(center: annotationSource.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        self.mapView.setRegion(region, animated: true)
        
        
        let directions = MKDirections(request: destinationReq)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Something is wrong \(error)")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay:  overlay as! MKPolyline)
        render.strokeColor = UIColor.init(named: LoginUser.getThemeColor)
        return render
    }
    
    
 
}
