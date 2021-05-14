//
//  DashboardView.swift
//  Covid Cases Visualizer
//
//  Created by Beau Nouvelle on 9/13/20.
//  Modified by Thomas Nguyen

import SwiftUI

struct DashboardView: View {

    @ObservedObject var apiService = APIService<Summary>()
    @State var showCountrySelectionScreen = false
    @State var selectedCountry: String? = UserDefaults.standard.string(forKey: DefaultKeys.selectedCountry)

    var body: some View {
        NavigationView {
            VStack {
                switch apiService.state {
                case .isLoading:
                    Text("Fetching Data...")
                case .hasData(let summary):
                    ScrollView {
                        HStack {
                            Spacer()
                            Button(action: {
                                showCountrySelectionScreen.toggle()
                            }, label: {
                                Image(systemName: "flag.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            })
                        }
                        .sheet(isPresented: $showCountrySelectionScreen, content: {
                            CountrySelectionView(countries: summary.Countries, selectedCountry: $selectedCountry)
                        })
                        .padding()
                        GlobalStatsView(globalStats: summary.Global)

                        if let slug = selectedCountry {
                            VStack(alignment: .leading) {
                                Text(slug.replacingOccurrences(of: "-", with: " ").capitalized)
                                    .font(.title)
                                    .padding(.top, 40)
                                CountryDetailsView(slug: slug)
                            }
                        } else {
                            VStack {
                                Button(action: {
                                    showCountrySelectionScreen.toggle()
                                }, label: {
                                    Text("Choose Country")
                                })
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .onAppear {
            apiService.getSummary()
        }
        .onChange(of: selectedCountry, perform: { value in
            UserDefaults.standard.setValue(value, forKey: DefaultKeys.selectedCountry)
            self.showCountrySelectionScreen = false
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
