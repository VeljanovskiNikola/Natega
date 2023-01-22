//
//  SmallSaintIconCard.swift
//  Natega
//
//  Created by Daniel Kamel on 22/01/2023.
//

import SwiftUI

struct SmallSaintIconCard: View {
    
    var iconCard: SaintIconModel = saintIconModels[0]
    
    var body: some View {
        
        VStack {
            
            Text("\(iconCard.name)")
                .font(Font.system(size: 15, design: .rounded).weight(.semibold))
                .foregroundColor(.white)
                .padding(5)
                .frame(maxWidth: .infinity) // this modifier for brown bar to take whole width of VStack
                .background(Color(iconCard.textBackgroundColour).opacity(0.9))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))// this modifier to push text to bottom of VStack
                
        }
        .background(SmallIcon()
            .blur(radius: 10)
            .offset(x:8, y: 11)
            .opacity(0.65)
            .overlay(SmallIcon())
        )
        .frame(maxWidth: 300, maxHeight: 350)
        
    }
}



struct SmallSaintIconCard_Previews: PreviewProvider {
    static var previews: some View {
        SmallSaintIconCard()
    }
}


