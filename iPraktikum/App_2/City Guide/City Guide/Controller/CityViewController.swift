//
//  CityViewController.swift
//  City Guide
//
//  Created by Paul Schmiedmayer on 10/8/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit
import MapKit

// MARK: - CityViewController: UIViewController
class CityViewController: UIViewController {
    
    // MARK: Variables
     var city: City!
    // MARK: IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countryAndStateLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    // The city that is displayed in the CityViewController
    // More on implicelty unwrapped optionals in Swift 3 🙂
   
    // MARK: override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = city.name
        countryAndStateLabel.text = city.location.state.rawValue + ", " + city.location.country.rawValue
        populationLabel.text = String(city.population)
        areaLabel.text = String(city.area)
        descriptionLabel.text = city.description
        mapView.centerOn(latitude: city.location.coordinates.coordinateX, longitude: city.location.coordinates.coordinateY, withAnAreaOf: city.area)
    }
}
