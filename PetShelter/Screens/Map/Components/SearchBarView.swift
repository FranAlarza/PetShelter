//
//  SearchBarView.swift
//  PetShelter
//
//  Created by Fran Alarza on 28/2/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var query: String
    @Binding var isSearching: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("Search", text: $query)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    isSearching = true
                }
            
            SearchOptionsView { search in
                query = search
                isSearching = true
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 10)
    }
}

#Preview {
    SearchBarView(query: .constant(""), isSearching: .constant(true))
}
