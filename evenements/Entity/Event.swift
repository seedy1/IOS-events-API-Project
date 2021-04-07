//
//  File.swift
//  evenements
//
//  Created by RAKOTONDRANORO Andriatiana Victor on 24/03/2021.
//

import Foundation

// App model
struct EventLocation {
    var id: String
    var spaceName: String
    var buildLocation: String
    var scheduledEvents: [String]
    var description: String
    var photos: [Photo]
    var createdTime: String
}

// EventLocation mapping to service
extension EventLocation {
    init(from raw: EventLocationService.RawEventLocation.Location) {
        id = raw.id;
        spaceName = raw.fields.spaceName;
        buildLocation = raw.fields.buildingLocation;
        scheduledEvents = raw.fields.scheduledEvents;
        description = raw.fields.description;
        photos = []
        for rawphoto in raw.fields.photos{
            photos.append(rawphoto)
        }
        createdTime = raw.createdTime;
    }
}

// Photo
struct Photo : Decodable {
    var id: String;
    var url: String;
    var filename: String;
    var size: Int;
    var type: String;
    var thumbnails:Thumbnail
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case url = "url"
        case filename = "filename"
        case size = "size"
        case type
        case thumbnails
    }
    
    struct Thumbnail: Decodable{
        var small, large, full: ThumbnailInfo
    }
    struct ThumbnailInfo: Decodable{
        var url: String
        var width, height: Int
    }
}

// EventLocation service
class EventLocationService: Service {
    
    override init(pathParam:String) {
        super.init(pathParam:Constants.EventLocationURL)
    }
    
    // Fetch all
    func fetchAll(onNewEventHandler: @escaping ([EventLocation]) -> Void){
        fetchURL(urlString: getPath(), onNewEventHandler: onNewEventHandler)
    }
    
    // Fetch all
    func fetchURL(urlString: String,
                  onNewEventHandler: @escaping ([EventLocation]) -> Void){
        //call fetcher service
        FetcherService().fetchJSON(fetchUrlString: urlString){ (locations:RawEventLocation) in
            let locationList = locations.records.map { EventLocation(from: $0) }
            // return to main thread
            DispatchQueue.main.async {
                /* Do async work here */
                onNewEventHandler(locationList)
            }
        }
    }
    
    
    
    // Inner service model serving as an intermediate for managing API
    struct RawEventLocation: Decodable {
        
        // List of records
        var records: [Location]
        enum RawKeys: String, CodingKey{
            case records = "records"
        }
        
        // record
        struct Location : Decodable{
            var id: String;
            var fields:Fields;
            var createdTime: String;
            
            enum CodingKeys: String, CodingKey{
                case id = "id", fields, createdTime
            }
            
            // Fields
            struct Fields: Decodable {
                var spaceName: String;          // Space name
                var buildingLocation: String;   // Building location
                var scheduledEvents: [String];  // Scheduled events
                var description: String;        // Description
                var photos: [Photo];
                var maxCapacity: Int;           // Max capacity

                enum CodingKeys: String, CodingKey{
                    case spaceName = "Space name"
                    case buildingLocation = "Building location"
                    case scheduledEvents = "Scheduled events"
                    case description = "Description"
                    case photos = "Photo(s)"
                    case maxCapacity = "Max capacity"
                }
            }
        }
    }
}
