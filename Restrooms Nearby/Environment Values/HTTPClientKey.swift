//
//  HTTPClientKey.swift
//  Restrooms Nearby
//
//  Created by Aarya Raut on 6/21/24.
//

import Foundation
import SwiftUI

private struct HTTPClientKey: EnvironmentKey {
    static var defaultValue: HTTPClient = RestroomClient()
}

extension EnvironmentValues {
    
    var httpClient: HTTPClient {
        get { self[HTTPClientKey.self] }
        set { self[HTTPClientKey.self] = newValue}
    }
}
