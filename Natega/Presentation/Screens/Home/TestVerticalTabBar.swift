//
//  TestVerticalTabBar.swift
//  Natega
//
//  Created by Daniel Kamel on 18/03/2023.
//

import SwiftUI

struct TestVerticalTabBar: View {
    var body: some View {
        
        ZStack{
            
            Color.gray.ignoresSafeArea()
          
            VStack {
                TabView {
                    
                    Text("First Tab")
                        .tabItem { Text("Tab 1") }
                        .rotationEffect(Angle(degrees: 270))
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis.")
                        .tabItem { Text("Tab 2") }
                        .rotationEffect(Angle(degrees: 270))
                    
                    Text("Third Tab")
                        .tabItem { Text("Tab 3") }
                        .rotationEffect(Angle(degrees: 270))
                    
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .rotationEffect(Angle(degrees: -270))
                
            }
            
        }
        

    }
}

struct TestVerticalTabBar_Previews: PreviewProvider {
    static var previews: some View {
        TestVerticalTabBar()
    }
}
