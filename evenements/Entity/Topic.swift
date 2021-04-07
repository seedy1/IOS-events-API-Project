//
//  Topic.swift
//  evenements
//
//  Created by RAKOTONDRANORO Andriatiana Victor on 24/03/2021.
//

import Foundation

struct Topic {
    var id: String;
    var topicTheme: String;
    var relevantEvents: [String]
    var count: Int
    var createdTime: String
}

// Topic mapping to service
extension Topic {
    init (from rawTopicList:TopicService.RawTopics.Record){
        id = rawTopicList.id;
        topicTheme = rawTopicList.fields.topicTheme;
        relevantEvents = rawTopicList.fields.relevantEventS;
        count = rawTopicList.fields.count;
        createdTime = rawTopicList.createdTime;
    }
}

// Topic service
class TopicService : Service {
    
    override init() {
        super.init(pathParam:Constants.TopicURL)
    }
    
    // Fetch all
    func fetchAll(onNewTopicHandler: @escaping ([Topic]) -> Void){
        fetchURL(urlString: getPath(), onNewTopicHandler: onNewTopicHandler)
    }
    
    // Fetch all from URL
    func fetchURL(urlString: String,
                  onNewTopicHandler: @escaping ([Topic]) -> Void){
        //call fetcher service
        FetcherService().fetchJSON(fetchUrlString: urlString){ (topics:RawTopics) in
            let topicList = topics.records.map { Topic(from:$0) }
            // return to main thread
            DispatchQueue.main.async {
                /* Do async work here */
                onNewTopicHandler(topicList)
            }
        }
    }
    
    // Inner service model serving as an intermediate for managing API
    struct RawTopics: Codable {
        var records: [Record]
        
        struct Record: Codable {
            var id: String
            var fields: Fields
            var createdTime: String
        }

        struct Fields: Codable {
            var relevantEventS: [String]
            var topicTheme: String
            var count: Int

            enum CodingKeys: String, CodingKey {
                case relevantEventS = "Relevant event(s)"
                case topicTheme = "Topic / theme"
                case count = "Count"
            }
        }
    }
}
