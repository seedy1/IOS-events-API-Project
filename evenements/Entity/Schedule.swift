//
//  Schedule.swift
//  evenements
//
//  Created by RAKOTONDRANORO Andriatiana Victor on 07/04/2021.
//

import Foundation

// App model
struct Schedule {
    var id: String
    var notes: String?
    var end: String
    var activity: String
    var type: String
    var start: String
    var location: [String]
    var topicTheme: [String]?
    var speakers: [String]?
    var createdTime: String
}

// Schedule mapping to service
extension Schedule {
    init(from raw: ScheduleService.RawSchedule.Record) {
        id = raw.id;
        notes = raw.fields.notes
        end = raw.fields.end
        activity =  raw.fields.activity
        type = raw.fields.type
        start = raw.fields.start
        location = raw.fields.location
        topicTheme = raw.fields.topicTheme
        speakers = raw.fields.speakerS
        createdTime = raw.createdTime;
    }
}

// EventLocation service
class ScheduleService {
    
    // Fetch all
    func fetchURL(urlString: String,
                  onNewscheduleHandler: @escaping ([Schedule]) -> Void){
        //call fetcher service
        FetcherService().fetchJSON(fetchUrlString: urlString){ (schedules:RawSchedule) in
            let schedulesList = schedules.records.map { Schedule(from: $0) }
            // return to main thread
            DispatchQueue.main.async {
                /* Do async work here */
                onNewscheduleHandler(schedulesList)
            }
        }
    }
    
    
    
    // Inner service model serving as an intermediate for managing API
    struct RawSchedule: Decodable {
        
        // List of records
        var records: [Record]
        enum RawKeys: String, CodingKey{
            case records = "records"
        }
        
        struct Record: Codable {
            var id: String
            var fields: Fields
            var createdTime: String
        }

        struct Fields: Codable {
            var notes: String?
            var end, activity, type, start: String
            var location: [String]
            var topicTheme, speakerS: [String]?

            enum CodingKeys: String, CodingKey {
                case notes = "Notes"
                case end = "End"
                case activity = "Activity"
                case type = "Type"
                case start = "Start"
                case location = "Location"
                case topicTheme = "Topic / theme"
                case speakerS = "Speaker(s)"
            }
        }
    }
}
