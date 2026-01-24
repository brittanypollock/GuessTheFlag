//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Brittany Pollock on 1/23/26.
//

import SwiftUI

struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}
