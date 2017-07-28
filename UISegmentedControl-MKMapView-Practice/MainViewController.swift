//
//  MainViewController.swift
//  UISegmentedControl-MKMapView-Practice
//
//  Created by Francis Tseng on 2017/7/28.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, MKMapViewDelegate {

    let mapView = MKMapView()
    
    var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 25.042467, longitude: 121.564871)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)

        let mySegmentedControl = UISegmentedControl()
        
        let xPostion: CGFloat = 10
        let yPostion: CGFloat = 25
        let elementWidth: CGFloat = view.frame.size.width-20
        let elementHeight: CGFloat = 30
        
        mySegmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        
        mySegmentedControl.insertSegment(withTitle: "welcome", at: 0, animated: true)

        mySegmentedControl.insertSegment(withTitle: "map", at: 1, animated: true)

        //Change text color of UISegmentedControl
        mySegmentedControl.tintColor = UIColor.yellow

        //Change UISegmentedControl background colour
        mySegmentedControl.backgroundColor = UIColor.black
        
        // Add function to handle Value Changed events
        mySegmentedControl.addTarget(self, action: #selector(MainViewController.segmentedValueChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(mySegmentedControl)
    }
    
    func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        if sender.selectedSegmentIndex == 0 {
            mapView.isHidden = true
            imageView.isHidden = false
            imageView  = UIImageView(frame: CGRect(x: 10, y: 25, width: view.frame.size.width-20, height: 300))
            imageView.image = UIImage(named:"appworks")
            self.view.addSubview(imageView)
            
            imageView.frame = CGRect(x: 10, y: 100, width: view.frame.size.width-20, height: 300)
            view.addSubview(imageView)
            
        } else {
            mapView.isHidden = false
            imageView.isHidden = true
            let leftMargin: CGFloat = 10
            let topMargin: CGFloat = 60
            let mapWidth: CGFloat = view.frame.size.width - 20
            let mapHeight: CGFloat = 650
            
            mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
            mapView.mapType = MKMapType.standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true
            
            let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
            
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 25.042467, longitude: 121.564871)
            
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            mapView.setRegion(region, animated: true)
            
            //self.mapView.showsUserLocation = true

            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = location
            annotation.title = "AppWorks School"
            annotation.subtitle = "AWESOME!!"
            mapView.addAnnotation(annotation)
            self.view.addSubview(mapView)
        }
    }
}
