//
//  HomeView.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.12.22.
//

import SwiftUI
import PartialSheet

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isBottomSheetPresented = false
    @State private var showPassages = false
    @State var tap = false
    @State private var currentSynaxar: Reading?
    @State private var currentPassage: Passage?
    
    
    private var chevronRightOpacity: CGFloat {
        viewModel.synaxars.count > 1 ? 1 : 0.5
    }
    
    var body: some View {
        contentView
            .partialSheet(isPresented: $isBottomSheetPresented, content: {
                SynaxariumDetailView(reading: currentSynaxar)
            })
            .partialSheet(isPresented: $showPassages, content: {
                PassagesDetailView(passage: currentPassage)
            })
            .onAppear {
                viewModel.loadReadings()
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
    
    private var commemorations: some View {
        Group {
            Text("Commemorations")
                .font(.system(size: 20, weight: .bold, design: .rounded))
            HStack {
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(Color.black.opacity(0.5))
                }
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal) {
                        ForEach(viewModel.synaxars) { synaxar in
                            Button {
                                currentSynaxar = synaxar
                                isBottomSheetPresented = true
                            } label: {
                                Text(synaxar.title ?? "No title")
                                    .lineLimit(1)
                                    .font(.system(size: 20, weight: .regular,
                                                  design: .rounded))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                Button {
                    
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(Color.black.opacity(chevronRightOpacity))
                }
                
            }
            .padding(.bottom, 10)
            .padding(.trailing, 16)
        }
    }
    
    private var readyView: some View {
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    //MARK: - Date
                    HStack {
                        Text("Today, \(viewModel.formattedDate())")
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
                        commemorations
                        
                        
                        //MARK: - Readings
                        Text("Readings")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.bottom, 10)
                        
                        //MARK: - Readings lazyVGrid
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.presentableSections) { presentableSection in
                                    HStack {
                                        VStack {
                                            ForEach(presentableSection.passages) { passage in
                                                Button {
                                                    showPassages = true
                                                    currentPassage = passage
                                                } label: {
                                                    Text("\(passage.bookTranslation ?? "") \(passage.ref)")
                                                }
                                            }
                                            Text("\(presentableSection.subSectionTitle) ∘ \(presentableSection.title)")
                                                .font(.caption2)
                                        }
                                    }
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Rectangle().fill(Color.darkBlue))
                                    .cornerRadius(16)
                                }
                            }
                        }
                        
                        //MARK: - Upcoming feasts
                        Text("Upcoming feasts")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.bottom, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 7) {
                                
                                HStack {
                                    
                                    Text("Feast of the Nativity")
                                        .font(.system(size: 20, weight: .medium, design: .rounded))
                                    
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
                                    
                                    Text("Feast of the Cross")
                                        .font(.system(size: 20, weight: .medium, design: .rounded))
                                    
                                    Image(systemName: "smallcircle.filled.circle.fill")
                                        .font(.system(size: 7, weight: .thin, design: .rounded))
                                    
                                    Text("in 2 days")
                                        .font(.system(size: 20, weight: .regular, design: .rounded))
                                    
                                }
                                .padding(.vertical, 15)
                                .padding(.horizontal, 35)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(30)
                                
                                
                                HStack {
                                    
                                    Text("St Mary's feast")
                                        .font(.system(size: 20, weight: .medium, design: .rounded))
                                    
                                    Image(systemName: "smallcircle.filled.circle.fill")
                                        .font(.system(size: 7, weight: .thin))
                                    
                                    Text("in 9 days")
                                        .font(.system(size: 20, weight: .regular, design: .rounded))
                                    
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
