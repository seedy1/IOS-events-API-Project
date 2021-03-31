//
//  Topic.swift
//  evenements
//
//  Created by RAKOTONDRANORO Andriatiana Victor on 24/03/2021.
//

import Foundation

struct Topic {
    var topic: String; // Topic/Theme
    var events: [String]; // Relevant events: Array of linked records IDs from schedule table
    var count: [Int]; // Number of linked schedule records
}
