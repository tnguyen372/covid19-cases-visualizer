//
//  GlobalStatsView.swift
//  Covid Cases Visualizer
//
//  Created by Beau Nouvelle on 9/13/20.
//  Modified by Thomas Nguyen

import Foundation
import SwiftUI

struct GlobalStatsView: View {

    let globalStats: GlobalStats

    var body: some View {
        VStack(spacing: 10) {
            VStack {
                Text("\(globalStats.TotalConfirmed - globalStats.TotalRecovered)")
                    .font(.largeTitle)
                    .foregroundColor(Color.red)
                Text("Active")
                    .font(.subheadline)
                    .foregroundColor(Color.init(.secondaryLabel))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.init(.secondarySystemBackground))
            )
            HStack {
                Group {
                    VStack {
                        Text("\(globalStats.TotalConfirmed)")
                            .font(.title2)
                            .foregroundColor(Color.orange)
                        Text("Confirmed")
                            .font(.subheadline)
                            .foregroundColor(Color.init(.secondaryLabel))
                    }
                    VStack {
                        Text("\(globalStats.TotalRecovered)")
                            .font(.title2)
                            .foregroundColor(Color.green)
                        Text("Recovered")
                            .font(.subheadline)
                            .foregroundColor(Color.init(.secondaryLabel))
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.init(.secondarySystemBackground))
                )
            }

        }
    }
}

struct GlobalStatsView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsView(globalStats: GlobalStats(TotalConfirmed: 3500, TotalRecovered: 2300))
            .previewLayout(.sizeThatFits)
    }
}
