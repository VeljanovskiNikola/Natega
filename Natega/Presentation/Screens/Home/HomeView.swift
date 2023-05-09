//
//  HomeView.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.12.22.
//
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var tapNategaPlus = false
    @State private var showSynaxars: Bool? = false
    @State private var showReadings: Bool? = false
    @State private var tapIcon = false
    @State private var reading: Reading?
    @State private var presentableSection: PresentableSection?
    @State private var imageTapped = false
    @State private var readingTapped = false
    @State private var selectedIcon: SaintIconModel?
    @State private var selectedCommemoration: Reading?
    @State private var selectedPresentableSection: PresentableSection?
    
    var body: some View {
        contentView
            .onAppear(perform: viewModel.onAppear)
            .buttonStyle(.plain)
            .redacted(reason: viewModel.state == .loading ? .placeholder : [])
            .animation(.easeInOut(duration: 0.5))
            .transition(.opacity)
    }
    
    //MARK: - Content
    @ViewBuilder
    private var contentView: some View {
        ScrollView(showsIndicators: false) {
            readyView
        }
        .background(backgroundColor)
    }
    
    private var readyView: some View {
        VStack(spacing: 0) {
            dateView
                .padding(.top, 16)
            fastView
                .padding(.top, 16)
            iconsView
            commemorations
            readings
            upcomingEvents
                .padding(.top, 16)
        }
    }
    
    //MARK: - Date
    private var dateView: some View {
        HStack {
            Text("Today, \(viewModel.formattedDate())")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            
            Image(systemName: "smallcircle.filled.circle.fill")
                .font(.system(size: 10, weight: .thin, design: .rounded))
            
            Text(viewModel.copticDate)
                .font(.system(size: 20, weight: .regular, design: .rounded))
        }
        .foregroundColor(.black)
    }
    
    //MARK: - Fast
    private var fastView: some View {
        Text(viewModel.fastView)
            .font(.system(size: 17, weight: .medium, design: .rounded))
            .foregroundColor(.black)
            .padding(.vertical, 7)
            .padding(.horizontal, 20)
            .background(Color.superLightBlue.opacity(0.3))
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .onTapGesture(perform: viewModel.showLiturgicalInfo)
    }
    
    private var iconsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: -20) {
                ForEach(viewModel.saintIconModels) { iconModel in
                    GeometryReader { proxy in
                        SaintIconImageView(iconModel: iconModel)
                            .padding(.top, 20)
                            .padding(.horizontal, 5)
                            .rotation3DEffect(
                                Angle(degrees: (Double(proxy.frame(in: .global).minX) - 100) / -50 ),
                                axis: (x: 0, y: 50, z: 0.0)
                            )
                    }
                    .frame(width: 350, height: 410)
                    .scaleEffect(selectedIcon == iconModel ? 1.2 : 1.0)
                    .onTapGesture {
                        withAnimation {
                            selectedIcon = iconModel
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation {
                                selectedIcon = nil
                            }
                        }
                    }
                }
            }
            .padding(10)
        }
    }
    
    private var commemorations: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Commemorations")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .padding(.horizontal, 16)
            HStack(spacing: 0) {
                if viewModel.synaxars.isEmpty {
                    // Add an empty view or placeholder here
                    Text("As today is a Major Feast of the Lord, the Synaxarium is not read today.")
                        .padding(.bottom, 5)
                        .padding(.horizontal, 16)
                } else {
                    TabView {
                        ForEach(viewModel.synaxars, id: \.title) { reading in
                            Text(reading.title ?? "")
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 5)
                                .padding(.horizontal, 16)
                                .scaleEffect(selectedCommemoration == reading ? 1.1 : 1.0)
                                .onTapGesture {
                                    withAnimation {
                                        selectedCommemoration = reading
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        withAnimation {
                                            selectedCommemoration = nil
                                            self.reading = reading
                                            showSynaxars = true
                                        }
                                    }
                                }
                        }
                    }
                    .halfSheet(showSheet: $showSynaxars) {
                        SynaxarsDetailsView(reading: $reading)
                    } onDismiss: { self.reading = nil }
                }
            }
            .multilineTextAlignment(.center)
            .font(.system(size: 20, weight: .regular, design: .rounded))
            .tabViewStyle(.page)
            .frame(height: 110)
            .padding(.top, -25)
        }
        .foregroundColor(.black)
    }
    
    private var readings: some View {
        VStack (alignment: .leading) {
            Text("Daily readings")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: -10) {
                    ForEach(viewModel.presentableSections.indices, id: \.self) { index in
                            ReadingSection(presentableSection: viewModel.presentableSections[index],
                                           hasOneName: viewModel.hasOneName(for: viewModel.presentableSections[index]),
                                           readingsColour: readingsColours[index % readingsColours.count])
                        .scaleEffect(selectedPresentableSection == viewModel.presentableSections[index] ? 1.2 : 1.0)
                        .onTapGesture {
                            withAnimation {
                                selectedPresentableSection = viewModel.presentableSections[index]
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation {
                                    selectedPresentableSection = nil
                                    presentableSection = viewModel.presentableSections[index]
                                    showReadings = true
                                }
                            }
                        }
                    }
                    .padding(.bottom, 8)
                }
                .padding(.top, -10)
                .halfSheet(showSheet: $showReadings) {
                    ReadingDetailsView(section: presentableSection)
                } onDismiss: { self.presentableSection = nil }
            }
            .foregroundColor(.black)
        }
    }
    
    private var upcomingEvents: some View {
        VStack(alignment: .leading) {
            Text("Upcoming feasts")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.bottom, 10)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    ForEach(viewModel.upcomingFeasts) { feast in
                        HStack {
                            Text(feast.name)
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                            Image(systemName: "smallcircle.filled.circle.fill")
                                .font(.system(size: 7, weight: .thin))
                            Text(feast.time)
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                        }
                        .padding(.vertical, 15)
                        .padding(.horizontal, 35)
                        .background(Color.white.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .foregroundColor(.black)
    }
    
    private var backgroundColor: some View {
        LinearGradient(gradient: .init(colors: [Color(#colorLiteral(red: 0.431372549, green: 0.6823632717, blue: 0.7646967769, alpha: 1)),
                                                Color(#colorLiteral(red: 0.9058917165, green: 0.8509779572, blue: 0.8588247299, alpha: 1)),
                                                Color(#colorLiteral(red: 0.9843173623, green: 0.96470505, blue: 0.9647064805, alpha: 1))]), startPoint: .top,
                       endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
    
    private struct SaintIconImageView: View {
        
        let iconModel: SaintIconModel
        
        var body: some View {
            Image(iconModel.name)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 300, maxHeight: 350)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(alignment: .bottom) {
                    Text(iconModel.name)
                        .font(Font.system(size: 15, design: .rounded).weight(.semibold))
                        .multilineTextAlignment(.center)
                        .padding(5)
                        .padding(.horizontal, 3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color(iconModel.textBackgroundColour).opacity(0.8))
                }
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .background(Image(iconModel.name)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 300, maxHeight: 350)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .blur(radius: 10)
                    .offset(x:8, y: 11)
                    .opacity(0.65)
                    .overlay(Image(iconModel.name)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 300, maxHeight: 350)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous)))
                )
                .frame(maxWidth: 300, maxHeight: 350)
        }
    }
}
