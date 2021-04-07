//
//  Speaker.swift
//  evenements
//
//  Created by RAKOTONDRANORO Andriatiana Victor on 24/03/2021.
//

import Foundation

// App model
struct Speaker {
    var id: String
    var role: String
    var company: [String]
    var status: String?
    var email: String
    var type: String
    var speakingAt: [String]?
    var name: String
    var phone: String
    var createdTime: String
}

// Schedule mapping to service
extension Speaker {
    init(from raw: SpeakerService.RawSpeaker.Record) {
        id = raw.id;
        role = raw.fields.role
        company = raw.fields.company
        status =  raw.fields.status
        email =  raw.fields.email
        type = raw.fields.type
        speakingAt = raw.fields.speakingAt
        name = raw.fields.name
        phone = raw.fields.phone
        createdTime = raw.createdTime;
    }
}

// EventLocation service
class SpeakerService : Service{
    
    override init() {
        super.init(pathParam:Constants.SpeakerURL)
    }
    
    // Fetch all
    func fetchURL(urlString: String,
                  onNewSpeakerHandler: @escaping ([Speaker]) -> Void){
        //call fetcher service
        FetcherService().fetchJSON(fetchUrlString: urlString){ (speakers:RawSpeaker) in
            let speakerList = speakers.records.map { Speaker(from: $0) }
            // return to main thread
            DispatchQueue.main.async {
                /* Do async work here */
                onNewSpeakerHandler(speakerList)
            }
        }
    }
    
    
    
    // Inner service model serving as an intermediate for managing API
    struct RawSpeaker: Decodable {
        
        // List of records
        var records: [Record]
        enum RawKeys: String, CodingKey{
            case records = "records"
        }
        
        struct Record: Codable {
            var id: String
            var fields: Fields
            var createdTime: String

            enum CodingKeys: String, CodingKey {
                case id = "id"
                case fields = "fields"
                case createdTime = "createdTime"
            }
        }

        struct Fields: Codable {
            var role: String
            var company: [String]
            var status: String?
            var email: String
            var type: String
            var speakingAt: [String]?
            var name: String
            var phone: String

            enum CodingKeys: String, CodingKey {
                case role = "Role"
                case company = "Company"
                case status = "Status"
                case email = "Email"
                case type = "Type"
                case speakingAt = "Speaking at"
                case name = "Name"
                case phone = "Phone"
            }
        }
    }
}

