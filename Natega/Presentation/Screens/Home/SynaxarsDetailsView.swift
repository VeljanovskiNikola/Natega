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
                            .font(.system(size: 20, weight: .bold))
                        Text(reading?.html ?? "")
                    }
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 24)
                }
            }
            .frame(width: 350)
        }
        .edgesIgnoringSafeArea(.bottom)

    }
}
