//
//  CountryDetailsView.swift
//  Covid Cases Visualizer
//
//  Created by Beau Nouvelle on 9/13/20.
//  Modified by Thomas Nguyen

import Foundation
import SwiftUI
import SwiftUICharts

struct CountryDetailsView: View {
    
    @ObservedObject var apiService = APIService<[LiveStats]>()
    
    var slug: String

        init(slug: String) {
            self.slug = slug
            apiService.getStats(slug: slug)
        }

        var body: some View {
            VStack {
                switch apiService.state {
                case .isLoading:
                    Text("Fetching Data...")
                case .hasData(let stats):
                    HStack(alignment: .lastTextBaseline) {
                        Group {
                            VStack {
                                Text("\(stats.last?.Confirmed ?? -1)")
                                    .font(.title2)
                                    .foregroundColor(Color.orange)
                                Text("Confirmed")
                                    .font(.subheadline)
                                    .foregroundColor(Color.init(.secondaryLabel))
                            }
                            VStack {
                                Text("\(stats.last?.Active ?? -1)")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.red)
                                Text("Active")
                                    .font(.subheadline)
                                    .foregroundColor(Color.init(.secondaryLabel))
                            }
                            
                            VStack {
                                Text("\(stats.last?.Recovered ?? -1)")
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
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.init(.secondarySystemBackground))
                    )
                
                    VStack {
                        LineChartView(data: rollingAverage(for: stats.map { $0.Confirmed }), title: "Confirmed Average", legend: "Confirmed", form: ChartForm.extraLarge, dropShadow: false)
                        LineChartView(data: rollingAverage(for: stats.map { $0.Active }), title:
                            "Active Average", legend: "Active", form: ChartForm.extraLarge, dropShadow: false)
                        LineChartView(data: rollingAverage(for: stats.map { $0.Recovered }), title: "Recovered Average", legend: "Recovered", form: ChartForm.extraLarge, dropShadow: false)
                        
                    }
                }
            }
        }

        func rollingAverage(for stats: [Int]) -> [Double] {
            var index = 0
            var averages = [Double]()

            while index+14 < stats.count {
                let chunk = Array(stats[index..<index+14])
                let sum = chunk.reduce(0, +)
                let average = Double(sum) / Double(14)
                averages.append(average)
                index += 1
            }

            return Array(averages.prefix(30)).reversed()
        }

    }

    struct CountryDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            CountryDetailsView(slug: "australia")
                .preferredColorScheme(.dark)
                .previewLayout(.device)
        }
    }
