//
//  LiveStats.swift
//  Covid Cases Visualizer
//
//  Created by Beau Nouvelle on 9/13/20.
//  Modified by Thomas Nguyen

import Foundation

struct LiveStats: Decodable {
    let Confirmed: Int
    let Active: Int
    let Recovered: Int
    let Date: String
}
