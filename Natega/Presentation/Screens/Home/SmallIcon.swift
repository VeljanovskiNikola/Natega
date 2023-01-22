//
//  SmallIcon.swift
//  Natega
//
//  Created by Daniel Kamel on 22/01/2023.
//

import SwiftUI

struct SmallIcon: View {
    
    var iconCard: SaintIconModel = saintIconModels[0]
    
    var body: some View {
        
        Image(uiImage: iconCard.image)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: 300, maxHeight: 350)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        
    }
}

struct SmallIcon_Previews: PreviewProvider {
    static var previews: some View {
        SmallIcon()
    }
}
