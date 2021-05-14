//
//  Summary.swift
//  Covid Cases Visualizer
//
//  Created by Beau Nouvelle on 9/13/20.
//  Modified by Thomas Nguyen

import Foundation

struct Summary: Decodable {
    let Global: GlobalStats
    let Countries: [Country]
}

