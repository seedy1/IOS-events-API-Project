//
//  FetcherService.swift
//  evenements
//
//  Created by RAKOTONDRANORO Andriatiana Victor on 31/03/2021.
//

import Foundation

class Fetcher {
    
    // A generic fetching function that fetches and parses a JSON downloaded
    // from a given Url
    func fetchJSON <T>(fetchUrlString:String, completionHandler: @escaping (T) -> Void) where T : Decodable {
        
        // Transform input string url into an URL object
        let url = URL(string: fetchUrlString)!
        
        
        // Fetching task declaration
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            //Error handling
            if let error = error {
                // Todo : link to the screen instead of print
                print("Error with fetching films: \(error)")
                return
            }
            // More error handling: http status code
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                // Todo : link to the screen instead of print
                print("Error with the response, unexpected status code: \(String(describing: response))")
            return
            }
            // JSON Decoding
            if let data = data,
                let decoded = try? JSONDecoder().decode(T.self, from: data) {
                completionHandler(decoded)
            }
        })
        
        // Launch task
        task.resume()
    }
    
    // EXAMPLE of how to use the function:
    //
    //
    // Note: RootLocation class is just an example class.
    // Replace it with your own!
    //
    // You need to have a class that implements Decodable and
    // maps the JSON you are trying to decode.
    
    /*
     class Main{
         private var locations: RootLocationClass?
         
         func run(){
             Fetcher().fetchAPI(fetchUrlString: testUrlString){ [weak self] (locations:RootLocationClass) in
     
                 self?.locations = locations
                 DispatchQueue.main.async {
                     /* Do async work here */
                   //self?.tableView.reloadData()
                     //print (locations)
                     print ("1st location name: ",locations.records[0].fields.locationName) // Saphire room
                     print ("2nd location name: ",locations.records[1].fields.locationName) // Garnet room
                 }
             }
         }
     }
     */
    
    // END OF EXAMPLE
}
