//
//  ContentView.swift
//  BucketList
//
//  Created by Rajabaliyev01 on 10/05/26.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 43, longitude: 69),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    var body: some View {
        
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .foregroundStyle(.red.gradient)
                                .frame(width: 44, height: 44)
                                .background(.ultraThinMaterial)
                                .clipShape(.circle)
                                .shadow(radius: 5)
                                .onTapGesture {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .mapStyle(.hybrid(elevation: .realistic))
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) {
                        viewModel.update(location: $0)
                    }
                }
            }
        } else {
            ZStack {
                LinearGradient(
                    colors: [Color(red:0.06, green:0.13, blue:0.22),
                             Color(red:0.1, green:0.18, blue:0.3)],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(.blue.opacity(0.8))
                    
                    Text("Places Locked")
                        .font(.title2.weight(.medium))
                        .foregroundStyle(.white)
                    
                    Button("Unlock", action: viewModel.authenticate)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .tint(.blue)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
