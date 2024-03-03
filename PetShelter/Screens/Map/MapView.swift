//
//  MapView.swift
//  PetShelter
//
//  Created by Fran Alarza on 24/2/24.
//

import SwiftUI
import MapKit

enum DisplayMode {
    case list
    case detail
}

struct MapView: View {
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var locationManager = LocationManager.shared
    @State private var query: String = ""
    @State private var selectedDetent: PresentationDetent = .fraction(0.15)
    @State private var isSearching: Bool = false
    @State private var mapItems: [MKMapItem] = []
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var selectedMapItem: MKMapItem?
    @State private var displayMode: DisplayMode = .list
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var route: MKRoute?
    
    private func search() async {
        do {
            mapItems = try await performSearch(searchTerm: query, visibleRegion: visibleRegion)
            print(mapItems)
            isSearching = false
        } catch {
            mapItems = []
            print(error.localizedDescription)
            isSearching = false
        }
    }
    
    private func requestCalculateDirections() async {
        guard let userLocation = locationManager.manager.location,
              let selectedMapItem
        else {
            return
        }
        let startingMapItem = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
        route = await calculateDirections(from: startingMapItem, to: selectedMapItem)
    }
    
    var body: some View {
        ZStack {
            Map(position: $position, selection: $selectedMapItem) {
                ForEach(mapItems, id: \.self) { item in
                    Marker(item: item)
                }
                
                if let route {
                    MapPolyline(route)
                        .stroke(.blue ,lineWidth: 5)
                }
                UserAnnotation()
            }
            .sheet(isPresented: .constant(true), content: {
                VStack {
                    switch displayMode {
                    case .list:
                        SearchBarView(query: $query, isSearching: $isSearching)
                        PlaceListView(mapItems: mapItems, selectedMapItem: $selectedMapItem)
                    case .detail:
                        VStack(spacing: 16) {
                            SelectedPlaceDetailView(mapItem: $selectedMapItem)
                            if selectedDetent == .medium || selectedDetent == .large {
                                if let selectedMapItem {
                                    ActionButtons(mapItem: selectedMapItem)
                                }
                                LookAroundPreview(initialScene: lookAroundScene)
                            }
                        }
                        .padding()
                    }
                    Spacer()
                }
                .padding(.top, 16)
                .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            })
            .mapControls({
                MapUserLocationButton()
                
            })
        }
        .onMapCameraChange{ context in
            visibleRegion = context.region
        }
        .onChange(of: selectedMapItem, {
            if selectedMapItem != nil {
                displayMode = .detail
            } else {
                displayMode = .list
            }
        })
        .task(id: selectedMapItem) {
            lookAroundScene = nil
            route = nil
            if let selectedMapItem {
                let request = MKLookAroundSceneRequest(mapItem: selectedMapItem)
                lookAroundScene = try? await request.scene
                await requestCalculateDirections()
            }
        }
        .task(id: isSearching, {
            if isSearching {
                await search()
            }
        })
    }
}

#Preview {
    MapView()
}
