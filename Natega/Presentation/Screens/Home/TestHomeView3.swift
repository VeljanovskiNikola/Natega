//
//  TestHomeView3.swift
//  Natega
//
//  Created by Daniel Kamel on 27/01/2023.
//

import SwiftUI

struct TestHomeView3: View {
    
    @State var tapFeast = false
    
    @State var tapNategaPlus = false
    
    @State var showSheet: Bool? = nil
    
    @State var tapIcon = false
    
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
                        .scaleEffect(tapFeast ? 1.08 : 1)
                        .onTapGesture {
                            
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                
                                tapFeast = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                        
                                        tapFeast = false
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
                                        .scaleEffect(tapIcon ? 1.1 : 1)
                                        .onTapGesture {
                                            
                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                                
                                                tapIcon = true
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                    
                                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                                        
                                                        tapIcon = false
                                                        
                                                    }
                                                    
                                                }
                                                
                                                
                                            }
                                        }
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
                            
                            TabDesign()

                        }
                        .frame(width: 400, height: 150)
                        .padding(.top, -40)
                        
                        //MARK: - Readings
                        Text("Readings")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.bottom, 10)
                        
                        //MARK: - Readings lazyVGrid
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
                                            .font(.system(size: 20, weight: .regular, design: .rounded))
                                            .underline()
                                        Image(systemName: "wand.and.stars")
                                            .font(.system(size: 20, weight: .regular, design: .rounded))
                                        
                                    }
                                    .scaleEffect(tapNategaPlus ? 1.1 : 1)
                                    .onTapGesture{
                                        
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                            
                                            tapNategaPlus = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                                
                                                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                                    
                                                    tapNategaPlus = false
                                                    
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
                                                            
                                                            Text("Natega Plus")
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
                                .padding(.vertical, 15)
                                .padding(.horizontal, 35)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(30)

                            }
                        }
                        .padding(.horizontal, 5)
                        .padding(.bottom, 50)
                            
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

struct TabDesign: View {
    var body: some View {
        
        TabView {
            
                Text("The Appearance of the Body of St. Apolidus (Hippolytus), Pope of Rome")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                Text("The Martyrdom of the Saints Abakir, John, the Three Virgins and Their Mother")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                Text("The Martyrdom of Sts. Agathon, Peter, John, Amun and Amuna and Their Mother, Rebecca")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                Text("Fourth")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            
        }
        .tabViewStyle(.page)
//        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct TestHomeView3_Previews: PreviewProvider {
    static var previews: some View {
        TestHomeView3()
    }
}
