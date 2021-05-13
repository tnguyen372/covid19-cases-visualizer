//
//  CountryDetailsView.swift
//  Covid Cases Visualizer
//
//  Created by Beau Nouvelle on 9/13/20.
//  Modified by Thomas Nguyen

import Foundation
import SwiftUI

struct CountryDetailsView: View {
    
    @ObservedObject var apiService = APIService<[LiveStats]>()
    
    let country: Country
    
    var body: some View {
    
            VStack {
                switch apiService.state {
                case .isLoading:
                    Text("Loading...")
                case .hasData(let stats):
                    Text("\(stats.last?.Cases ?? -1)")
                }
            }
            .onAppear {
                apiService.getStats(slug: country.slug)
            }
        
    }
}
