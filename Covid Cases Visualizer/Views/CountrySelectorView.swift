//
//  CountrySelectorView.swift
//  Covid Cases Visualizer
//
//  Created by Beau Nouvelle on 9/13/20.
//  Modified by Thomas Nguyen

import Foundation
import SwiftUI

struct CountrySelectionView: View {

    let countries: [Country]
    @Binding var selectedCountry: String?

    var body: some View {
        List(countries.sorted { $0.name < $1.name}, id: \.slug) { country in
            Button(action: {
                selectedCountry = country.slug
            }, label: {
                HStack {
                    Text(country.name)
                    Spacer()
                    Text("\(country.totalRecoveredAbbr)/\(country.totalConfirmedAbbr)")
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(Font.system(.body).monospacedDigit())
                        .multilineTextAlignment(.trailing)
                }
            })
        }
    }
}
