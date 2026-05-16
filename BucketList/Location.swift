//
//  Location.swift
//  BucketList
//
//  Created by Rajabaliyev01 on 15/05/26.
//

import Foundation
import MapKit

struct Location: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
   
    static let example = Location(id: UUID(), name: "", description: "", latitude: 69, longitude: 43)
  
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
