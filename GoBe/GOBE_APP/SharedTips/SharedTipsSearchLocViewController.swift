//
//  SharedTipsSearchLocViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 29/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

class SharedTipsSearchLocViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var txtfield_searhLocation: UITextField!
    @IBOutlet weak var btn_Address: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var Dict_SharedEvent : NSDictionary!

    var str_visibility : NSString?

    var Latitude : Double = 0.0
    var Longitude : Double = 0.0

    @IBOutlet weak var tblview_location: UITableView!
    
    var searchController: UISearchController?
    var arrLocationList = NSMutableArray ()
    var responseData:NSMutableData?
    var dataTask:URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        tblview_location.isHidden=true

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btn_backClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Tableview Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrLocationList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: Cell_locationSearch? = (tableView.dequeueReusableCell(withIdentifier: "Cell_locationSearch") as? Cell_locationSearch)
        
        let dictCell = arrLocationList.object(at: indexPath.row) as! NSDictionary
        
        cell?.lbl_Address.text = dictCell.value(forKey: "place_address") as? String
        // cell?.imgIcon.image = UIImage(named: dictCell.value(forKey: "icon") as! String)
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictCell = arrLocationList.object(at: indexPath.row) as! NSDictionary
        print(dictCell.value(forKey: "place_address") as? String as Any)
        
        if let strAddres = dictCell.value(forKey: "place_address") as? String{
            
            btn_Address.setTitle(strAddres, for: .normal)
        }
        let placesClient = GMSPlacesClient()
        let placeID = dictCell.object(forKey: "place_id") as! String
        
        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
            if let error = error
            {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeID)")
                return
            }
            self.Latitude = place.coordinate.latitude
            self.Longitude = place.coordinate.longitude
            self.addAnnotations()

        })
        tblview_location.isHidden=true
    }
    @IBAction func btn_OKClick(_ sender: Any) {
        
        let move = self.storyboard?.instantiateViewController(withIdentifier: "SharedEventPodSelection") as! SharedEventPodSelection
        move.Dict_SharedEvent = Dict_SharedEvent
        move.str_Address = btn_Address.titleLabel?.text as? NSString
        move.str_visibility = str_visibility
        
        self.navigationController?.pushViewController(move, animated: true)
    }
    @IBAction func handleValueChangeLocationSearch(_ sender: UITextField){

        fetchAutocompletePlaces(inputText: txtfield_searhLocation.text!)
    }
    
    func fetchAutocompletePlaces(inputText : String)
    {
        tblview_location.isHidden=false

        let urlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=\(GoogleMapsRestClient.GMS_API_KEY)&input=\(inputText)"
        
        let s = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
        s.addCharacters(in: "+&")
        if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: s as CharacterSet) {
            if let url = URL(string: encodedString) {
                let request = URLRequest(url: url)
                dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                    if let data = data{
                        
                        do{
                            let result  = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                            print(result)
                            
                            if let status = result["status"] as? String
                            {
                                if status == "OK"
                                {
                                    if let predictions = result["predictions"] as? NSArray
                                    {
                                        self.arrLocationList.removeAllObjects()
                                        //var locations = [String]()
                                        for dict in predictions as! [NSDictionary]
                                        {
                                            print(dict)
                                            
                                            let tempdict : [String : Any] = [
                                                "place_name":dict.object(forKey: "description")!,
                                                "place_address":dict.object(forKey: "description")!,
                                                "latitude":"",
                                                "longitude":"",
                                                "isHome":"",
                                                "place_id":dict.object(forKey: "place_id")!
                                            ]
                                            self.arrLocationList.add(tempdict)
                                            self.tblview_location.reloadData()
                                        }
                                        DispatchQueue.main.async {
                                            self.tblview_location.reloadData()
                                        }
                                        return
                                    }
                                }
                                else
                                {
                                    self.arrLocationList.removeAllObjects()
                                    self.tblview_location.reloadData()
                                    self.tblview_location.isHidden=true
                                }
                            }
                            
                            DispatchQueue.main.async {
                                self.txtfield_searhLocation.text = nil
                            }
                        }
                        catch let error as NSError{
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                })
                dataTask?.resume()
            }
        }
    }
    func addAnnotations()
    {
        let CLLCoordType = CLLocationCoordinate2D(latitude: CLLocationDegrees(Latitude),
                                                  longitude: CLLocationDegrees(Longitude));
        let anno = MKPointAnnotation();
        anno.coordinate = CLLCoordType;
        mapView.addAnnotation(anno);
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }

    @IBAction func searchfieldCross_Click(_ sender: Any) {
    }

}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


