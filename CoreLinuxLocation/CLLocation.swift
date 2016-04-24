//
//  CLLocation.swift
//  CoreLinuxLocation
//
//  Created by Jimmy Chan on 4/23/16.
//  Copyright © 2016 Projek J. All rights reserved.
//

import Foundation

typealias CLLocationDegrees = Double
typealias CLLocationAccuracy = Double
typealias CLLocationDistance = Double
typealias CLLocationSpeed = Double
typealias CLLocationDirection = Double

public struct CLLocationCoordinate2D {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    init() {
        latitude = 0
        longitude = 0
    }
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public class CLLocation: NSObject {
    private(set) var coordinate: CLLocationCoordinate2D
    private(set) var altitude: CLLocationDistance = 0
    private(set) var horizontalAccuracy: CLLocationAccuracy = 0
    private(set) var verticalAccuracy: CLLocationAccuracy = 0
    @NSCopying private(set) var timestamp  = NSDate()
    private(set) var speed: CLLocationSpeed = 0
    private(set) var course: CLLocationDirection = 0
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, timestamp: NSDate) {
        
        self.coordinate = coordinate
        self.altitude = altitude
        self.horizontalAccuracy = hAccuracy
        self.verticalAccuracy = vAccuracy
        self.timestamp = timestamp
    }
    
    init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, course: CLLocationDirection, speed: CLLocationSpeed, timestamp: NSDate) {
        
        self.coordinate = coordinate
        self.altitude = altitude
        self.horizontalAccuracy = hAccuracy
        self.verticalAccuracy = vAccuracy
        self.course = course
        self.speed = speed
        self.timestamp = timestamp
    }
    
    func distanceFromLocation(location: CLLocation) -> CLLocationDistance {
        let R = 6371000.0;
        let dLat = (coordinate.latitude - location.coordinate.latitude) * M_PI/180.0
        let dLon = (coordinate.longitude - location.coordinate.longitude) * M_PI/180.0
        let lat1 = location.coordinate.latitude * M_PI/180.0
        let lat2 = coordinate.longitude * M_PI/180.0
        
        let a = sin(dLat/2.0) * sin(dLat/2.0) + sin(dLon/2.0) * sin(dLon/2.0) * cos(lat1) * cos(lat2);
        let c = 2 * atan2(sqrt(a), sqrt(1-a));
        let d = R * c;
        return d
    }
}