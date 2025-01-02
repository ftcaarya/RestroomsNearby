//
//  HTTPClient.swift
//  Restrooms Nearby
//
//  Created by Aarya Raut on 6/21/24.
//

import Foundation

protocol HTTPClient {
    func fetchRestrooms(url: URL) async throws -> [Restroom]
}
