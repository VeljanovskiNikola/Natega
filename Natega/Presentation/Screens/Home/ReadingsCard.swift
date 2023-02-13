//
//  ReadingsCard.swift
//  Natega
//
//  Created by Daniel Kamel on 05/02/2023.
//

import SwiftUI

struct ReadingsCard: View {
    
    var readingModel: ReadingsModel = readingsModel[0]
    
    var body: some View {
        
        VStack (spacing: 5) {
            
            HStack {
                
                Text("\(readingModel.bookTranslation0)")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                Text("\(readingModel.bookRef0)")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                
            }
            
            HStack {
                
                Text("\(readingModel.bookTranslation1)")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                Text("\(readingModel.bookRef1)")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                
            }
            .padding(.bottom, 7)
            
            HStack (spacing: 3) {
                
                Text("\(readingModel.subSectionsTitle)")
                    .font(.system(size: 15, weight: .light, design: .rounded))
                Image(systemName: "smallcircle.filled.circle.fill")
                    .font(.system(size: 5, weight: .ultraLight, design: .rounded))
                Text("\(readingModel.sectionsTitle)")
                    .font(.system(size: 15, weight: .light, design: .rounded))
            }
            
            
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .background(Color(uiColor: readingModel.backgroundColour))
        .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Color(uiColor: readingModel.shadowColour).opacity(0.7), radius: 10, x: 0, y:15)
        .padding()

    }
}

struct ReadingsCard_Previews: PreviewProvider {
    static var previews: some View {
        ReadingsCard()
    }
}

/*
 In order to make sure they all appear same size in horiztonal scroll, perhaps make a if statement that basically says:
    if "psalm" not present, then put book ref on second line
 This could be done with VStack.
 
 I also want both readings horiztonal scroll and upcoming feasts horizontal scroll to ignore the left and right edges of the phone. Couldn't figure out how to do it. I do not have this problem with the Icon Scroll though which is interesting.
 */
