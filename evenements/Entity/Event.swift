//
//  File.swift
//  evenements
//
//  Created by RAKOTONDRANORO Andriatiana Victor on 24/03/2021.
//

import Foundation

struct Event {
    var locationName: String; // Space name
    var address: String; // Building Location
    var schedules: [String]; // Scheduled events
    var description: String; // Description
    var photos: [Photo]; //Photos
    var maxCapacity: [Int]; //Max capacity
}

