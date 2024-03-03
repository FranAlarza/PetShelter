//
//  ContentView.swift
//  PetShelter
//
//  Created by Fran Alarza on 22/2/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let hikes: [Hike] = [.init(name: "Salmonberry Trail", photo: "sal", miles: 6),
                         .init(name: "Tom, Dick and Harry Mountain", photo: "tom", miles: 5.8),
                         .init(name: "Tamanawas Falls", photo: "tam", miles: 5)]
    
    @State var filteredHikes: [Hike] = []
    @State var search: String = ""

    var body: some View {
        NavigationStack {
            List(filteredHikes) { hike in
                NavigationLink(value: hike) {
                    HikeCellView(hike: hike)
                }
            }
            .searchable(text: $search)
            .onChange(of: search) {
                if search.isEmpty {
                    filteredHikes = hikes
                } else {
                    filteredHikes = hikes.filter { $0.name.lowercased().contains(search.lowercased()) }
                }
            }
            .navigationTitle("Hikes")
            .navigationDestination(for: Hike.self) { hike in
                Image(hike.photo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .onAppear {
                filteredHikes = hikes
            }
        }
    }
}

struct HikeCellView: View {
    let hike: Hike
    
    var body: some View {
        HStack {
            Image(hike.photo)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(hike.name)
                Text(hike.miles.formatted())
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
