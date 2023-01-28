//
//  SmallIcon.swift
//  Natega
//
//  Created by Daniel Kamel on 22/01/2023.
//

import SwiftUI

struct SmallIconScroll: View {
    
    var iconCard: SaintIconModel = saintIconModels[0]
    
    @State var tap = false
    
    var body: some View {
        
        VStack {
            
            Text("\(iconCard.name)")
                .font(Font.system(size: 15, design: .rounded).weight(.semibold))
                .foregroundColor(.white)
                .padding(5)
                .padding(.horizontal, 3)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity) // this modifier for brown bar to take whole width of VStack
                .background(Color(iconCard.textBackgroundColour).opacity(0.9))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))// this modifier to push text to bottom of VStack
                
        }
        .background( Image(uiImage: iconCard.image)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: 300, maxHeight: 350)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .blur(radius: 10)
            .offset(x:8, y: 11)
            .opacity(0.65)
            .overlay( Image(uiImage: iconCard.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 300, maxHeight: 350)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous)))
        )
        .frame(maxWidth: 300, maxHeight: 350)
        .scaleEffect(tap ? 1.1 : 1)
        .onTapGesture {
            
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                
                tap = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        
                        tap = false
                        
                    }
                    
                }
                
                
            }
        }
        
    }
}

struct SmallIconScroll_Previews: PreviewProvider {
    static var previews: some View {
        SmallIconScroll()
    }
}
