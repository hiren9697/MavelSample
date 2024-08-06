//
//  JSONParser.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/08/24.
//

import Foundation

/// Class used to parse common JSONs, like list
class JSONParser {
    
    func parseListJSON(_ json: Any)-> [NSDictionary]? {
        guard let dict = json as? NSDictionary else {
            return nil
        }
        guard let data = dict["data"] as? NSDictionary else {
            return nil
        }
        guard let results = data["results"] as? [NSDictionary] else {
            return nil
        }
        return results
    }
}
