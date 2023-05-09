//
//  ButtonStyle.swift
//  Natega
//
//  Created by Nikola Veljanovski on 9.3.23.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    @State private var isTapped = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.08 : 1)
            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: configuration.isPressed)
    }
}


struct TapToScaleModifier: ViewModifier {
    @State private var isTapped = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isTapped ? 1.08 : 1)
            .animation(.spring(response: 0.4, dampingFraction: 0.6))
            .simultaneousGesture(TapGesture().onEnded {
                withAnimation {
                    isTapped.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isTapped.toggle()
                    }
                }
            })
    }
}

/*
 
 This is the closest to what i want:
 
 struct GrowingButton: ButtonStyle {
     @State private var isTapped = false
     
     func makeBody(configuration: Configuration) -> some View {
         configuration.label
             .scaleEffect(configuration.isPressed ? 1.08 : 1)
             .onChange(of: configuration.isPressed) { isPressed in
                 isTapped = isPressed
             }
     }
 }

 but there is no animation when this happens :/
 
 
 */
