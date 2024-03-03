//
//  SelectedPlaceDetailView.swift
//  PetShelter
//
//  Created by Fran Alarza on 29/2/24.
//

import SwiftUI
import MapKit

struct SelectedPlaceDetailView: View {
    
    @Binding var mapItem: MKMapItem?
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                if let mapItem {
                    MapListItem(item: mapItem)
                }
            }
            Image(systemName: "xmark.circle.fill")
                .onTapGesture {
                    mapItem = nil
                }
        }
    }
}

#Preview {
    
    let previewData = Binding<MKMapItem?>( get: {
        PreviewData.apple }, set: {  _ in })

    return SelectedPlaceDetailView(mapItem: previewData)
}
