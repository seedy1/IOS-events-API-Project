//
//  Sponsor.swift
//  evenements
//
//  Created by RAKOTONDRANORO Andriatiana Victor on 07/04/2021.
//

import Foundation

// App model
struct Sponsor {
    var id: String
    var contacts: [String]?
    var company: String
    var status: String
    var sponsoredAmount: Int?
    var notes: String?
    var previousSponsor: Bool?
    var createdTime: String
}

// Schedule mapping to service
extension Sponsor {
    init(from raw: SponsorService.RawSponsor.Record) {
        id = raw.id;
        contacts = raw.fields.contactS
        company = raw.fields.company
        status =  raw.fields.status
        sponsoredAmount = raw.fields.sponsoredAmount
        notes = raw.fields.notes
        previousSponsor = raw.fields.previousSponsor
        createdTime = raw.createdTime;
    }
}

// EventLocation service
class SponsorService : Service{
    
    override init(pathParam:String) {
        super.init(pathParam:Constants.SponsorURL)
    }
    
    // Fetch all
    func fetchAll(onNewSponsorHandler: @escaping ([Sponsor]) -> Void){
        fetchURL(urlString: getPath(), onNewSponsorHandler: onNewSponsorHandler)
    }
    
    // Fetch all from URL
    func fetchURL(urlString: String,
                  onNewSponsorHandler: @escaping ([Sponsor]) -> Void){
        //call fetcher service
        FetcherService().fetchJSON(fetchUrlString: urlString){ (sponsors:RawSponsor) in
            let sponsorsList = sponsors.records.map { Sponsor(from: $0) }
            // return to main thread
            DispatchQueue.main.async {
                /* Do async work here */
                onNewSponsorHandler(sponsorsList)
            }
        }
    }
    
    
    
    // Inner service model serving as an intermediate for managing API
    struct RawSponsor: Decodable {
        
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
            var contactS: [String]?
            var company: String
            var status: String
            var sponsoredAmount: Int?
            var notes: String?
            var previousSponsor: Bool?

            enum CodingKeys: String, CodingKey {
                case contactS = "Contact(s)"
                case company = "Company"
                case status = "Status"
                case sponsoredAmount = "Sponsored amount"
                case notes = "Notes"
                case previousSponsor = "Previous sponsor"
            }
        }
    }
}
