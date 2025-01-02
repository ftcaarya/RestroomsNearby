//
//  Constants.swift
//  Restrooms Nearby
//
//  Created by Aarya Raut on 6/21/24.
//

import Foundation

struct Constants {
    struct Urls {
        static func restroomByLocation(latitude: Double, longitude: Double) ->
        URL {
            return URL(string:
                "https://www.refugerestrooms.org/api/v1/restrooms/by_location?lat=\(latitude)&lng=\(longitude)"
            )!
        }
    }
}
