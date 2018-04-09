//
//  MKMapViewExtension.swift
//  City Guide
//
//  Created by Paul Schmiedmayer on 10/8/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import MapKit

// A MKMapView extension to simplify the code to display a city in the CityViewController
extension MKMapView {
    func centerOn(latitude: Double, longitude: Double, withAnAreaOf area: Double) {
        // Center the map on the coordinate provided
        let mapCenter = CLLocationCoordinate2D(latitude: latitude,
                                               longitude: longitude)
        // The zoom level should broadly fit the area
        let regionSize = sqrt(area)*2000
        let region = regionThatFits(MKCoordinateRegionMakeWithDistance(mapCenter, regionSize, regionSize))
        
        guard !(region.span.latitudeDelta.isNaN || region.span.longitudeDelta.isNaN) else {
            print("Area to be displayed is too large!")
            self.setCenter(mapCenter, animated: true)
            return
        }
        
        // Center the map on the given region
        self.setRegion(region, animated: true)
    }
}
