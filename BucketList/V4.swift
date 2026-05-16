//
//  V4.swift
//  BucketList
//
//  Created by YancharQuyon on 13/05/26.
//

import SwiftUI
import MapKit

struct Loaction: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct V4: View {
    let locations = [
        Loaction(name: "somewhere", coordinate: CLLocationCoordinate2D(latitude: 41.296, longitude: 69.277)) //
        
    ]
    var body: some View {
        VStack {
            MapReader { proxi in
            Map()
                    .mapStyle(.hybrid(elevation: .realistic))
                    .onTapGesture { position in
                        if let coordinate = proxi.convert(position, from: .local) {
                            print(coordinate)
                        }
                    }
            }
            
            Map{
                
            
               
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Text(location.name)
                            .font(.system(size: 10))
                            .padding()
                            .background(.blue.gradient)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                    }
                    .annotationTitles(.hidden)
                }
            }
        }
    }
}


#Preview {
    V4()
}
