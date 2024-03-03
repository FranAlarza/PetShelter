//
//  SearchOptionsView.swift
//  PetShelter
//
//  Created by Fran Alarza on 28/2/24.
//

import Foundation
import SwiftUI

struct SearchOptionsView: View {
    
    let searchOptions = [
        "Restaurants": "fork.knife",
        "Hotels": "bed.double.fill",
        "Coffe": "cup.and.saucer.fill",
        "Gas": "fuelpump.fill",
        "Pet Shelters": "dog.fill"
    ]
    
    let onSelected: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(searchOptions.sorted(by: >), id: \.key) { key, value in
                    Button(action: {
                        onSelected(key)
                    }, label: {
                        HStack {
                            Image(systemName: value)
                            Text(key)
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(.gray.opacity(0.3))
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    SearchOptionsView(onSelected: { _ in })
}
