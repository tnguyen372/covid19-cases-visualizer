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
                    VStack {
                        Text("\(stats.last?.Active ?? -1)")
                            .font(.largeTitle)
                            .foregroundColor(Color.red)
                        Text("Active")
                            .font(.subheadline)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.init(.secondarySystemBackground))
                    )
                    HStack(alignment: .lastTextBaseline) {
                        Group {
                            VStack {
                                Text("\(stats.last?.Confirmed ?? -1)")
                                    .font(.title2)
                                    .foregroundColor(Color.orange)
                                Text("Confirmed")
                                    .font(.subheadline)
                                    .foregroundColor(Color.black)
                            }
                            
                            
                            VStack {
                                Text("\(stats.last?.Recovered ?? -1)")
                                    .font(.title2)
                                    .foregroundColor(Color.green)
                                Text("Recovered")
                                    .font(.subheadline)
                                    .foregroundColor(Color.black)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.init(.secondarySystemBackground))
                        )
                    }
                    // Bar Graphs
                    VStack {
                        BarChartView(data: ChartData(values: [("Confirmed",(stats.last?.Confirmed ?? -1)), ("Active",(stats.last?.Active ?? -1)), ("Recovered",(stats.last?.Recovered ?? -1))]), title: "Country Cases Since Day 1", style: Styles.barChartStyleNeonBlueLight, form: ChartForm.extraLarge)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    // Line Graphs
                    VStack {
                        Group {
                        MultiLineChartView(
                            data: [
                                (rollingAverage(for: stats.map { $0.Confirmed }), GradientColors.orange),
                                (rollingAverage(for: stats.map { $0.Active }), GradientColors.orngPink),
                                (rollingAverage(for: stats.map { $0.Recovered }), GradientColors.green)
                            ], title: "Category Averages", form: ChartForm.extraLarge
                            )
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        
                        LineChartView(data: rollingAverage(for: stats.map { $0.Confirmed }), title: "Confirmed Average", legend: "% Change", form: ChartForm.extraLarge, dropShadow: true)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        LineChartView(data: rollingAverage(for: stats.map { $0.Active }), title:
                            "Active Average", legend: "% Change", form: ChartForm.extraLarge, dropShadow: true)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        LineChartView(data: rollingAverage(for: stats.map { $0.Recovered }), title: "Recovered Average", legend: "% Change", form: ChartForm.extraLarge, dropShadow: true)
                            .padding(.top, 10)
                        }
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
            CountryDetailsView(slug: "United States")
                .preferredColorScheme(.dark)
                .previewLayout(.device)
        }
    }
