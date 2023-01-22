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
                viewModel.loadReadings()
                viewModel.loadSynaxars()
            }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loading: loadingView
        case .ready: readyView
        }
    }
    
    private var loadingView: some View {
        ProgressView()
    }
    
    private var readyView: some View {
        ZStack {
            VStack {
                date
                fast
                image
                commemorations
                readingsSection
                upcoming
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.black)
        .background(
            LinearGradient(gradient: .init(colors: [Color(#colorLiteral(red: 0.431372549, green: 0.6823632717, blue: 0.7646967769, alpha: 1)), Color(#colorLiteral(red: 0.9058917165, green: 0.8509779572, blue: 0.8588247299, alpha: 1)), Color(#colorLiteral(red: 0.9843173623, green: 0.96470505, blue: 0.9647064805, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
        )
    }
    
    private var date: some View {
        HStack {
            Text("Today, \(viewModel.formattedDate())")
                .font(.system(size: 20, weight: .medium, design: .rounded))
            
            Image(systemName: "smallcircle.filled.circle.fill")
                .font(.system(size: 10, weight: .thin, design: .rounded))
            
            Text("17 Kiahk")
                .font(.system(size: 20, weight: .regular, design: .rounded))
        }
        .foregroundColor(Color.black)
        .padding(.top, 18)
    }
    
    private var fast: some View {
        Text("Nativity Fast")
            .font(.system(size: 17, weight: .regular, design: .rounded))
            .padding(.vertical, 7)
            .padding(.horizontal, 20)
            .background(Color.superLightBlue.opacity(0.3))
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        
    }
    
    private var image: some View {
        VStack {
//            TabView(selection: $viewModel.selectedImage) {
//                ForEach(viewModel.imageNames, id: \.self) { image in
//                    Image(uiImage: UIImage(named: image)!)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .cornerRadius(20)
//                        .padding(16)
//                        .tag(viewModel.imageNames.firstIndex(of: image) ?? 0)
//                }
//            }
//            .tabViewStyle(.page)
            
            Text("The feast of St. Mary")
                .font(.system(size: 13))
                .fontWeight(.regular)
        }
    }
    
    private var commemorations: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Commemorations")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .padding(.top, 20)
            
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
            //                readingsSecondRow
            //                readingsThirdRow
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
            ForEach(viewModel.readings) { reading in
                Button(action: {
                    // show detail view
                }, label:{
                    Text(reading.type)
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
                    Text(reading.type)
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
                    Text(reading.type)
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
                .font(.system(size: 15, weight: .semibold))
                .padding(.top, 20)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    
                    HStack {
                        
                        Text("Feast of the Nativity")
                            .font(.system(size: 15, weight: .medium))
                        
                        Image(systemName: "smallcircle.filled.circle.fill")
                            .font(.system(size: 7, weight: .thin))
                        
                        Text("in 6 days").font(.system(size: 15, weight: .light))
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(30)
                    
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
                    .cornerRadius(30)
                    
                    
                    HStack {
                        
                        Text("St Mary's feast")
                            .font(.system(size: 15, weight: .medium))
                        
                        Image(systemName: "smallcircle.filled.circle.fill")
                            .font(.system(size: 7, weight: .thin))
                        
                        Text("in 9 days").font(.system(size: 15, weight: .light))
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(30)
                }
                .padding(.horizontal, 16)
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
}
