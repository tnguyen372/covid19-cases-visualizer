//
//  CountriesView.swift
//  Covid Cases Visualizer
//
//  Created by Beau Nouvelle on 9/13/20.
//  Modified by Thomas Nguyen

import SwiftUI

struct CountriesView: View {
    
    @ObservedObject var apiService = APIService<[Country]>()
    
    
    var body: some View {
        NavigationView {
            VStack {
                switch apiService.state {
                case .isLoading:
                    Text("Loading...")
                case .hasData(let countries):
                    List(countries.sorted { $0.name < $1.name}, id: \.code) {
                        country in NavigationLink(
                            destination: CountryDetailsView(country: country),
                            label: {
                                Text(country.name)
                            })
                        }
                    }
            }
        }
        .onAppear {
            apiService.getCountries()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}
