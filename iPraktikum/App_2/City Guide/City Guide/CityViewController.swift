//
//  CityViewController.swift
//  City Guide
//
//  Created by Paul Schmiedmayer on 10/8/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit
import MapKit

class CityViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countryAndStateLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    // Add more @IBOutlets here
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var populationLabel: UILabel!
    
    @IBOutlet weak var areaLabel: UILabel!
    // The city that is displayed in the CityViewController
    // More on implicelty unwrapped optionals in Swift 3 🙂
    var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = city.name
        countryAndStateLabel.text = city.location.state.rawValue + ", " + city.location.country.rawValue
        populationLabel.text = String(city.population)
        areaLabel.text = String(city.area)
        
        mapView.centerOn(latitude: city.location.coordinates.coordinateX, longitude: city.location.coordinates.coordinateY, withAnAreaOf: city.area)
        
        
    
        // Center the map on your city with the following method:
        // mapView.centerOn(latitude: <#T##Double#>, longitude: <#T##Double#>, withAnAreaOf: <#T##Double#>)
        
        // Task 4: To display a city use the CityViewController which is automatically instantiated for you for every city by the CitiesViewController. The layout should be similar as in the screenshot and the layout should adapt the to different display sizes. If there is not enough space on a device, truncate the description. The map should be centered on the city using the method provided in MKMapViewExtension
        
    }
}
