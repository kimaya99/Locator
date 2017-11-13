//
//  MapUsers.swift
//  Assignment5
//
//  Created by Kimaya Desai on 11/10/17.
//  Copyright © 2017 SDSU. All rights reserved.
//

import UIKit
import Alamofire
import MapKit



class MapUsers: UIViewController {
    
  
    @IBOutlet var labelToDisplay: UILabel!
    @IBOutlet var useMapView: MKMapView!
    var userData = [AnyObject]()
    
    var passed : String = ""
    var countryValue : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let span = MKCoordinateSpanMake(150.0, 150.0)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:0.0,longitude: 0.0), span: span)
        useMapView.setRegion(region, animated: true)
        
        labelToDisplay.text = countryValue
        mapper(labelToDisplay: labelToDisplay.text!)
     }
    
    func mapper(labelToDisplay: String){
        print(labelToDisplay)
        Alamofire.request("http://bismarck.sdsu.edu/hometown/users?country=\(labelToDisplay)").responseJSON{
            response in
          
            print(self.countryValue)
            if let DataJSON = response.result.value {
                if let DataObject = DataJSON as?  Array<Dictionary<String, Any>>
                {
                        var x : Int = 0
                        var count = DataObject.count
                        while(count != 0 ){
    
                                var DictObject = DataObject[x]
                                let annotation = MKPointAnnotation()
                                annotation.title = DictObject["nickname"] as? String
       
                                annotation.coordinate = CLLocationCoordinate2D(latitude:DictObject["latitude"] as! Double, longitude: DictObject["longitude"] as! Double)
       
        
                                self.useMapView.addAnnotation(annotation)
                                count -= 1
                                x += 1
                        }
                }
            else
                {
                    let alert = UIAlertController(title:"Error",message:"Failed to load the map", preferredStyle : .alert)
                    let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                    alert.addAction(closeAction)
                    self.present(alert,animated: true,completion: nil)
                }
    
            }
        }
    }
}



