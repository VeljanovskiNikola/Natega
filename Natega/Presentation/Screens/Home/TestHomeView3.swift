//
//  TestHomeView3.swift
//  Natega
//
//  Created by Daniel Kamel on 27/01/2023.
//

import SwiftUI

struct TestHomeView3: View {
    
    @State var tap = false
    
    var body: some View {
        
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    //MARK: - Date
                    HStack {
                        Text("Today, 26th Jan")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                        
                        Image(systemName: "smallcircle.filled.circle.fill")
                            .font(.system(size: 10, weight: .thin, design: .rounded))
                        
                        Text("17 Kiahk")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                    }
                    .foregroundColor(Color.black)
                    .padding(.top, 10)
                    
                    //MARK: - Fast
                    Text("Nativity Fast")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .padding(.vertical, 7)
                        .padding(.horizontal, 20)
                        .background(Color.superLightBlue.opacity(0.3))
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .scaleEffect(tap ? 1.08 : 1)
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
                    
                    //MARK: - Icon Scroll View
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: -20) {
                            
                            ForEach(saintIconModels) { e in
                                
                                GeometryReader { geometry in
                                    
                                    SmallIconScroll(iconCard: e)
                                        .rotation3DEffect(
                                            Angle(degrees: (Double(geometry.frame(in: .global).minX) - 100) / -50 ),
                                            axis: (x: 0, y: 50, z: 0.0)
                                        )
                                }
                                .frame(width: 350, height: 400)
                                
                            }
                            
                        }
                        .padding(20)
                        
                    }
                    
                    //MARK: - VStack containing: commemorations, readings, upcoming fasts
                    VStack (alignment: .leading, spacing: 10) {
                        
                        //MARK: - Commemorations View
                        Text("Commemorations")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                        HStack {
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 17, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.black.opacity(0.5))
                            }
                            Text("The Departure of Saint Christodoulos")
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                            Button {
                                
                            } label: {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 17, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.black.opacity(1))
                            }
                            
                        }
                        .padding(.bottom, 10)
                        
                        
                        //MARK: - Readings
                        Text("Readings")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.bottom, 10)
                        
                        //MARK: - Readings horizontal scroll
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(spacing: -10) {
                                
                                ForEach(readingsModel) { e in
                                        
                                        ReadingsCard(readingModel: e)
                                        .padding(.bottom, 20)
                                    
                                }
                                
                            }
                            
                        }
                        .padding(.top, -20)
                        
                        
                        //MARK: - Upcoming feasts
                        Text("Upcoming feasts")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.bottom, 10)
                            .padding(.top, -10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 7) {
                                
                                HStack {
                                    
                                    Text("Feast of the Nativity")
                                        .font(.system(size: 20, weight: .medium, design: .rounded))
//                                        .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.235))
                                    
                                    Image(systemName: "smallcircle.filled.circle.fill")
                                        .font(.system(size: 7, weight: .thin))
                                    
                                    Text("in 6 days")
                                        .font(.system(size: 20, weight: .regular, design: .rounded))
                                    
                                }
                                .padding(.vertical, 15)
                                .padding(.horizontal, 35)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(30)
                                
                                HStack {
                                    
                                    Text("Just kidding")
                                        .font(.system(size: 20, weight: .medium, design: .rounded))
                                    
                                    Image(systemName: "smallcircle.filled.circle.fill")
                                        .font(.system(size: 7, weight: .thin, design: .rounded))
                                    
                                    Text("gotcha 😆")
                                        .font(.system(size: 20, weight: .regular, design: .rounded))
                                    
                                }
                                .padding(.vertical, 15)
                                .padding(.horizontal, 35)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(30)
                                
                                
                                HStack {
                                    
                                    Text("Live data for upcoming feasts")
                                        .font(.system(size: 20, weight: .medium, design: .rounded))
                                    
                                    Image(systemName: "smallcircle.filled.circle.fill")
                                        .font(.system(size: 7, weight: .thin))
                                    
                                    Text("with")
                                        .font(.system(size: 20, weight: .regular, design: .rounded))
                                    
                                    HStack (spacing: 2) {
                                        
                                        Text("Natega Plus")
                                            .font(.system(size: 20, weight: .medium, design: .rounded))
                                        Image(systemName: "wand.and.stars")
                                            .font(.system(size: 20, weight: .regular, design: .rounded))
                                        
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 9)
                                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.894, opacity: 0.73))
                                    .mask(RoundedRectangle(cornerRadius: 5, style: .continuous))
                                    
                                    
                                    
                                }
                                .padding(.vertical, 15)
                                .padding(.horizontal, 35)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(30)


                            }
                        }
                        .padding(.horizontal, 5)
                        .padding(.bottom, 20)
                            
                    }
                    .padding(.top, -40)
                    .padding(.leading, 20)
                    
                }
            }
            
        }
        .background(
            LinearGradient(gradient: .init(colors: [Color(#colorLiteral(red: 0.431372549, green: 0.6823632717, blue: 0.7646967769, alpha: 1)), Color(#colorLiteral(red: 0.9058917165, green: 0.8509779572, blue: 0.8588247299, alpha: 1)), Color(#colorLiteral(red: 0.9843173623, green: 0.96470505, blue: 0.9647064805, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
        )
    }
}

struct TestHomeView3_Previews: PreviewProvider {
    static var previews: some View {
        TestHomeView3()
    }
}
