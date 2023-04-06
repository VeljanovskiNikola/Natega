//
//  HalfSheetView.swift
//  Natega
//
//  Created by Nikola Veljanovski on 14.3.23.
//

import SwiftUI

struct SynaxarsDetailsView: View {
    @Binding var reading: Reading?
    
    var body: some View {
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
                        Text(reading?.title ?? "")
                            .font(Font.system(size: 20, design: .rounded).weight(.medium))
                            .multilineTextAlignment(.center)
                        Text(reading?.html ?? "")
                            .font(Font.system(size: 20, design: .rounded).weight(.light))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.bottom, 24)
                }
            }
            .frame(width: 350)
            .foregroundColor(.black)
        }
        .edgesIgnoringSafeArea(.bottom)

    }
}
