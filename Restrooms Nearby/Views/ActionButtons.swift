//
//  ActionButtons.swift
//  Restrooms Nearby
//
//  Created by Aarya Raut on 6/21/24.
//

import SwiftUI
import MapKit

struct ActionButtons: View {
    
    let mapItem: MKMapItem
    
    var body: some View {
        HStack {
            
            Button(action: {
                MKMapItem.openMaps(with: [mapItem])
            }, label: {
                HStack {
                    HStack {
                        Image(systemName: "car.circle.fill")
                        Text("Take me there")
                    }
                }
            }).buttonStyle(.bordered)
                .tint(.green)
            
            
            Spacer()
        }
        
        
    }
}

