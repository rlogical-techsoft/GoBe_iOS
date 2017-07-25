//
//  LocationSearchViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 24/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lbl_placeName: UILabel!
    @IBOutlet weak var txt_searchLocation: UITextField!
    @IBOutlet weak var btn_Arrow: UIButton!
    @IBOutlet weak var btn_getDirection: UIButton!
    
    var locationName : NSString!
    var EventTilte : NSString!
    var Latitude : NSString!
    var longitude : NSString!

    override func viewDidLoad() {
        super.viewDidLoad()

        txt_searchLocation.text = locationName! as String
        lbl_placeName.text = EventTilte! as String

        self.addAnnotations()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:-Button Event 
    
    @IBAction func btn_backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_ClickGetDirection(_ sender: Any) {
        
        if btn_getDirection.isSelected == true
        {
            btn_Arrow.isHighlighted = false
            btn_getDirection.isSelected = false
        }
        else{
            btn_Arrow.isHighlighted = true
            btn_getDirection.isSelected = true
        }
        
        //Mitul Code
        self.navigateToMap(lat1: Latitude as String, lng1: longitude as String , strAddress: locationName as String)
        
        //Manoj Code
        
//        let directionsURL: String? = "http://maps.apple.com/?saddr=\(mapView.userLocation.coordinate.latitude),\(mapView.userLocation.coordinate.longitude)&daddr=\(Latitude.floatValue),\(longitude.floatValue)"
//        UIApplication.shared.openURL(URL(string: directionsURL!)!)

    }
    
    
    // MARK: - Map delegate
     func addAnnotations()
     {
            let CLLCoordType = CLLocationCoordinate2D(latitude: CLLocationDegrees(Latitude.floatValue),
                                                      longitude: CLLocationDegrees(longitude.floatValue));
            let anno = MKPointAnnotation();
            anno.coordinate = CLLCoordType;
            mapView.addAnnotation(anno);
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
     }

    
    //MARK:- NavigateToMap
    func navigateToMap(lat1:String,lng1:String,strAddress:String) -> Void {
        
        let latitude:CLLocationDegrees = Double(lat1)!
        let longitude:CLLocationDegrees = Double(lng1)!
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = strAddress
        mapItem.openInMaps(launchOptions: options)
    }

}
