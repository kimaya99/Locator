//
//  LocationViewController.swift
//  Assignment5
//
//  Created by Kimaya Desai on 11/6/17.
//  Copyright © 2017 SDSU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol VCFinalDelegate {
    func finishPassing(string: String, string2: String)
}

class LocationViewController: UIViewController {
    
    var delegate: VCFinalDelegate?

    var latitudeL = ""
    var longitudeL = ""
    
    var x : String = ""
    var y : String = ""
    
    var locationManager:CLLocationManager = CLLocationManager()
   
    @IBOutlet var latLongLabel: UILabel!
    @IBOutlet var latLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var compAddress: UITextView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
   
    
    @IBAction func setLoo(_ sender: Any) {
        
     
            delegate?.finishPassing(string: "\(x)",string2:"\(y)")
            
            let alert = UIAlertController(title:"Location",message:"Set to \(x) \(y)", preferredStyle : .alert)
            let closeAction = UIAlertAction(title: "Go Back", style: .cancel, handler: nil)
            alert.addAction(closeAction)
            self.present(alert,animated: true,completion: nil)
            }
    
    
        
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         x = latitudeL
        y = longitudeL
        
    
      
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopUpdatingLocation()
        
        mapView!.mapType = MKMapType.standard
        mapView!.showsUserLocation = true
        mapView!.showsTraffic = true
        print(mapView!.isUserLocationVisible)
        
        placePoint(one: Double(x) ?? 32.955,two: Double(y) ?? -117.2459)

    }
   
    func placePoint( one : Double,two : Double){
        let annotation = MKPointAnnotation()
        let encinitas =
            CLLocationCoordinate2DMake(one, two)
        annotation.coordinate = encinitas
        
        self.mapView.addAnnotation(annotation)
    }
    
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        
       
        let location = sender.location(in: self.mapView)
        let locCord = self.mapView.convert(location,toCoordinateFrom:self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locCord
        annotation.title = "A"
        annotation.subtitle = "Location"
        
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotation(annotation)
        
    
        x = String(locCord.longitude)
        y = String(locCord.latitude)
        
        latLongLabel.text = x
        latLabel.text = y 
        
        let locator = CLGeocoder()
        
        locator.reverseGeocodeLocation(
        CLLocation(latitude: locCord.latitude, longitude: locCord.longitude)) { (placemarks, errors) in
            if let place = placemarks?[0] {
                if let opt1 = place.locality{
                    if let opt2 = place.administrativeArea {
                   if let opt3 = place.country
                   {
                        self.compAddress.text = "\(opt1),\(opt2),\(opt3)"
                    }
                }
            }
                   else {
                self.compAddress.text = "Address not Found"
            } }
    }

}
}
