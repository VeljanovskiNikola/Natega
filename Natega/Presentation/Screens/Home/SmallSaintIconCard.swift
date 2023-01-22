//
//  SmallSaintIconCard.swift
//  Natega
//
//  Created by Daniel Kamel on 22/01/2023.
//

import SwiftUI

struct SmallSaintIconCard: View {
    
    var iconCard: SaintIconModel = saintIconModels[0]
    
    @State var tap = false
    
    @State var show = false
    
    var body: some View {
        
        ZStack {
            SmallIconWithName()
                .scaleEffect(tap ? 1.2: 1)
                .animation(.spring(response: 0.4, dampingFraction: 0.6))
                .onTapGesture {
                        tap = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                tap = false
                        }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        show.toggle()
                    }
                }

            if show {
                LargeIcon()
                    .padding(.top, 300)
                // really struggling with ordering the animation... I want the scale effect to happen first, then for largeicon to appear with an animation... why is this so hard to do? the large icon appears after due to dispatchqueue but i can't seem to animate it regardless what i do....
                
                /*
                 
                 To do next:
                    - add blur and motion to LargeIconWithMotion
                    - figure out this dumb animation thing
                    - the reason we are animating this file, is so that when i pull it into horizontal scroll in HomeView, I can loop through the array of icons for the horizontal scroll view and yet also tap on any one of the cards and the big version of the icon will appear with cool animation
                    - right now my brain is fried
                 
                 */
            }
            
        }
        
    }
}

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

struct SmallIconWithName: View {
    
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

struct LargeIcon: View {
    
    var iconCard: SaintIconModel = saintIconModels[0]
    
    var body: some View {
        
        GeometryReader { geo in
            
            Image(uiImage: iconCard.image)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding(.horizontal, 30)
                .frame(width: geo.size.width * 1)
                .frame(width: geo.size.width, height: geo.size.height)
            
        }
        
    }
    
}

struct LargeIconMotion: View {
    
    var iconCard: SaintIconModel = saintIconModels[0]
    
    var body: some View {
        
        LargeIcon()
        
        //need to add blur and stuff to large icon as well as motion
        
    }
    
}


struct SmallSaintIconCard_Previews: PreviewProvider {
    static var previews: some View {
        SmallSaintIconCard()
    }
}


