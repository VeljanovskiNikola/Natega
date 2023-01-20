//
//  HomeView.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.12.22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        contentView
            .onAppear {
                viewModel.loadData()
                setupAppearance()
            }
    }
    
    private var contentView: some View {
        VStack {
            if viewModel.feastResult == nil {
                ProgressView()
            } else {
                date
                fast
                image
                commemorations
                readingsSection
                upcoming
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.black)
        .background(
            LinearGradient(gradient: .init(colors: [Color(#colorLiteral(red: 0.4313035607, green: 0.6823632717, blue: 0.7646967769, alpha: 1)), Color(#colorLiteral(red: 0.9058917165, green: 0.8509779572, blue: 0.8588247299, alpha: 1)), Color(#colorLiteral(red: 0.9843173623, green: 0.96470505, blue: 0.9647064805, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)

        )
    }
    
    private var date: some View {
        HStack {
            Text("Today, \(viewModel.formattedDate())")
                .fontWeight(.medium)
                .font(.system(size: 15))
            
            Image(systemName: "smallcircle.filled.circle.fill")
                .font(.system(size: 7, weight: .thin, design: .rounded))
            
            Text("17 Kiahk")
                .font(.system(size: 15))
        }
        .padding(.top, 18)
    }
    
    private var fast: some View {
        Text("Nativity Fast")
            .font(.system(size: 13, weight: .regular, design: .rounded))
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            .background(Color.superLightBlue.opacity(0.3))
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))

    }
    
    private var image: some View {
        TabView {
            Image(uiImage: UIImage(named: "church")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .padding(16)
            
            Image(uiImage: UIImage(named: "stmary")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .padding(16)
        }
        .tabViewStyle(.page)
    }
    
    private var commemorations: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Commemorations")
                .font(.system(size: 15))
                .fontWeight(.semibold)
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 12)).opacity(0.3)
                        .foregroundColor(.black)
                }
                
                Text("The Departure of Saint Christodoulos")
                    .font(.system(size: 15, weight: .regular))
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var readingsSection: some View {
        Group {
            readingsTitle
            readingsFirstRow
            readingsSecondRow
            readingsThirdRow
        }
    }
    private var readingsTitle: some View {
        HStack {
            Text("Readings")
                .font(.system(size: 15, weight: .semibold))
                .padding(.top, 20)
                .frame(alignment: .leading)
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    private var readingsFirstRow: some View {
        HStack {
            ForEach(viewModel.readings[0...2]) { reading in
                Button(action: {
                    // show detail view
                }, label:{
                    Text(reading.title ?? "")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color.lightTurquoise)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 13)
                        .background(Color.lightBlue)
                        .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
                })
            }
        }
    }
    
    private var readingsSecondRow: some View {
        HStack {
            ForEach(viewModel.readings[3...4]) { reading in
                Button(action: {
                    // show detail view
                }, label:{
                    Text(reading.title ?? "")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color.softPink)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 13)
                        .background(Color.pink)
                        .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
                })
            }
        }
    }
    
    private var readingsThirdRow: some View {
        HStack {
            ForEach(viewModel.readings[5...5]) { reading in
                Button(action: {
                    // show detail view
                }, label:{
                    Text(reading.title ?? "")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color.purple)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 13)
                        .background(Color.lightPurple)
                        .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
                })
            }
        }
    }
    
    private var upcoming: some View {
        VStack(alignment: .leading) {
            Text("Upcoming")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    
                    HStack {
                        
                        Text("Feast of the Nativity")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                        
                        Image(systemName: "smallcircle.filled.circle.fill")
                            .font(.system(size: 7, weight: .thin, design: .rounded))
                        
                        Text("in 6 days").font(.system(size: 15, weight: .light, design: .rounded))
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(Color.white.opacity(0.7))
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.8984375, green: 0.9023876190185547, blue: 0.9375, alpha: 1)), radius:40, x:0, y:20)
                    
                    HStack {
                        
                        Text("Feast of the Cross")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                        
                        Image(systemName: "smallcircle.filled.circle.fill")
                            .font(.system(size: 7, weight: .thin, design: .rounded))
                        
                        Text("in 2 days").font(.system(size: 15, weight: .light, design: .rounded))
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(Color.white.opacity(0.7))
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.8984375, green: 0.9023876190185547, blue: 0.9375, alpha: 1)), radius:40, x:0, y:20)
                    
                    HStack {
                        
                        Text("St Mary's feast")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                        
                        Image(systemName: "smallcircle.filled.circle.fill")
                            .font(.system(size: 7, weight: .thin, design: .rounded))
                        
                        Text("in 9 days").font(.system(size: 15, weight: .light, design: .rounded))
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(Color.white.opacity(0.7))
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.8984375, green: 0.9023876190185547, blue: 0.9375, alpha: 1)), radius:40, x:0, y:20)
                    
                }
                    .shadow(color: Color.black.opacity(1), radius:40, x:10, y:50)
                    
//                    .shadow(color: Color(.black), radius:10, x:0, y:5)
                    
                    
                }
//                .frame(height: 500)
//                .padding(50)
                

            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .ignoresSafeArea()
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.white)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.lightPurple)
    }

