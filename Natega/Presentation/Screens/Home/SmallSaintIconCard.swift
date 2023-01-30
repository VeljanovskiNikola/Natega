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
    
    @ObservedObject var motionManager = MotionManager()
    private let maxDegrees: Double = 30 // clip max rotation angle
    private let rotationScale: Double = 0.5
    
    @State var viewState = CGSize.zero
    
    var body: some View {
        
        ZStack {
            
            SmallIconWithName()
                .scaleEffect(tap ? 1.2 : 1)

            if show {
                
                Rectangle()
                    .fill(Color(hue: 1.0, saturation: 0.0, brightness: 0.951, opacity: 0.376))
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .animation(.easeInOut)
                
                LargeIcon()
                    .background(LargeIcon()
                        .blur(radius: 15)
                        .rotation3DEffect(
                            max(min(Angle.radians(motionManager.magnitude * rotationScale), Angle.degrees(maxDegrees)), Angle.degrees(-maxDegrees))
                            ,
                            axis: (x: CGFloat(motionManager.x), y: CGFloat(motionManager.y), z: 0.0)
                        )
                        .offset(x:8, y: 11)
                        .opacity(0.65)
                        .overlay(LargeIcon())
                    )
                    .rotation3DEffect(
                        max(min(Angle.radians(motionManager.magnitude * rotationScale), Angle.degrees(maxDegrees)), Angle.degrees(-maxDegrees))
                        ,
                        axis: (x: CGFloat(motionManager.x), y: CGFloat(motionManager.y), z: 0.0)
                    )
                    .offset(x: viewState.width, y: viewState.height)
                    .animation(.easeIn(duration: 0.2))
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                    .gesture(
                        DragGesture().onChanged { value in

                            viewState = value.translation
                            
                        }
                            .onEnded { value in
                                
                                viewState = .zero
                                
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                    show = false
                                }
                                    
                            }

                    )
            }
            
        }
        .onTapGesture {
            
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                tap = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        
                        tap = false
                        
                    }
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.23) {
                    
                    withAnimation(.easeIn(duration: 0.2)) {
                        
                        show = true
                        
                    }
                    
                }
                
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
            .background(LargeIcon()
                .blur(radius: 15)
                .offset(x:8, y: 11)
                .opacity(0.65)
                .overlay(LargeIcon())
            )
        
    }
    
}


struct SmallSaintIconCard_Previews: PreviewProvider {
    static var previews: some View {
        SmallSaintIconCard()
    }
}


