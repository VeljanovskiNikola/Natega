//
//  ReadingsCard.swift
//  Natega
//
//  Created by Daniel Kamel on 05/02/2023.
//

import SwiftUI

struct ReadingsCard: View {
    
    var readingModel: ReadingsModel = readingsModel[0]
    
    @State var tapReading = false
    
    @State var showSheet: Bool? = nil
    
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
        .scaleEffect(tapReading ? 1.1 : 1)
        .onTapGesture {
            
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                
                tapReading = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        
                        tapReading = false
                        
                    }
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        
                        showSheet = true
                        
                    }
                    
                }
                
                
            }
        }
        .halfSheet(showSheet: $showSheet) {
            
            ZStack {
                
                Color.white
                
                VStack {
                   
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .frame(width: 40, height: 5)
                        .foregroundColor(.black.opacity(0.3))
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack (spacing: 10) {
                            

                            
                            HStack {
                                
                                Text("Matins Gospel")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .padding()
                                
                            }
                            .padding(.bottom, 10)
                            
                            Text("Psalms 11:12 - 14:9")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                            
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                .padding(.bottom, 10)
                            
                            Text("Matt 14: 22 - 23:19")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                            
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                .padding(.bottom, 50)
                            
                        }
                        .frame(width: 350) //this should be done via geometry reader to take width of screen and divide by a certain amount to give user space on edges of VStack to pull up manipulate sheet up and down.
                    }
                    
                }
                

            }
            .edgesIgnoringSafeArea(.bottom)
        } onDismiss: {
            print("sheet dismissed")
        }

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
