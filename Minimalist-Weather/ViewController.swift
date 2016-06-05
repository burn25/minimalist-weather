//
//  ViewController.swift
//  Minimalist-Weather
//
//  Created by Jeremy Burnham on 6/1/16.
//  Copyright © 2016 Jeremy Burnham. All rights reserved.
//

import UIKit
import CoreLocation

var isFahrenheit = true
var temperaturs = [String]()
var icons = [String]()

class ViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var collection: UICollectionView!
    
    var weather: Weather!
    var forcast: Forcast!
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        roundView.layer.cornerRadius = roundView.frame.size.width / 2
        roundView.clipsToBounds = true
        
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        let long = "\(userLocation.coordinate.longitude)"
        let lat = "\(userLocation.coordinate.latitude)"
        
        weather = Weather(lat: lat, lon: long)
        forcast = Forcast(lat: lat, lon: long)
        
        weather.downloadWeather { () -> () in
            self.forcast.downloadForcast { () -> () in
                self.loadUI()
                self.collection.reloadData()
            }
        }
        
        locationManager.stopUpdatingLocation()
    
    }
    
    
    
    func loadUI() {
        if isFahrenheit {
            tempLbl.text = weather.temp + " °F"
        } else {
            tempLbl.text = weather.temp + " °C"
        }
        weatherIcon.image = UIImage(named: weather.icon)
        minTemp.text = weather.minTemp
        maxTemp.text = weather.maxTemp
        windSpeed.text = weather.windSpeed
        humidity.text = weather.humidity
        cityLbl.text = weather.name


    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ForcastCell", forIndexPath: indexPath)
            as? ForcastCell {
            
            
            cell.configurecCell(indexPath.row)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(55, 55)
    }
    

}

