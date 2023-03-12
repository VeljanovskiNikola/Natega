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
    @State private var showSheet: Bool? = nil
    @State private var tapIcon = false
    
    var body: some View {
        contentView
            .onAppear(perform: viewModel.onAppear)
            .buttonStyle(.plain)
    }
    
    //MARK: - Content
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .ready:
            ScrollView(showsIndicators: false) {
                readyView
            }
            .background(backgroundColor)
        }
    }
    
    private var readyView: some View {
        VStack(spacing: 0) {
            dateView
                .padding(.top, 16)
            fastView
                .padding(.top, 16)
            iconsView
        }
    }
    
    //MARK: - Date
    private var dateView: some View {
        HStack {
            Text("Today, \(viewModel.formattedDate())")
                .font(.system(size: 20, weight: .semibold))
            
            Image(systemName: "smallcircle.filled.circle.fill")
                .font(.system(size: 10, weight: .thin))
            
            Text(viewModel.copticDate)
                .font(.system(size: 20, weight: .regular))
        }
        .foregroundColor(.black)
    }
    
    //MARK: - Fast
    private var fastView: some View {
        Text("Nativity Fast")
            .font(.system(size: 17, weight: .medium))
            .foregroundColor(.black)
            .padding(.vertical, 7)
            .padding(.horizontal, 20)
            .background(Color.superLightBlue.opacity(0.3))
            .cornerRadius(30)
    }
    
    private var iconsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(viewModel.saintIconModels) { iconModel in
                    GeometryReader { proxy in
                        Button { } label: {
                            SaintIconImageView(iconModel: iconModel)
                                .padding(.top, 40)
                                .padding(.bottom, 32)
                                .padding(.horizontal, 16)
                        }
                        .buttonStyle(GrowingButton())
                        .rotation3DEffect(
                            .degrees(proxy.frame(in: .global).minX / 10),
                            axis: (x: 1, y: 1, z: 0.0)
                        )
                    }
                    .frame(width: 350, height: 400)
                }
            }
        }
    }
    
    private var backgroundColor: some View {
        LinearGradient(gradient: .init(colors: [Color(#colorLiteral(red: 0.431372549, green: 0.6823632717, blue: 0.7646967769, alpha: 1)),
                                                Color(#colorLiteral(red: 0.9058917165, green: 0.8509779572, blue: 0.8588247299, alpha: 1)),
                                                Color(#colorLiteral(red: 0.9843173623, green: 0.96470505, blue: 0.9647064805, alpha: 1))]), startPoint: .top,
                       endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
}

private struct SaintIconImageView: View {
    let iconModel: SaintIconModel
    
    var body: some View {
        Image(iconModel.name)
            .resizable()
            .scaledToFit()
            .overlay(alignment: .bottom) {
                Text(iconModel.name)
                    .font(.system(size: 15, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(5)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color(iconModel.textBackgroundColour).opacity(0.9))
            }
            .cornerRadius(12)
            .frame(maxWidth: 300, maxHeight: 350)
            .shadow(color: .black.opacity(0.7),
                    radius: 8,
                    x: 0,
                    y: 0)
    }
}
