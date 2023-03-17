//
//  ReadingDetailsView.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.3.23.
//

import SwiftUI

struct ReadingDetailsView: View {
    let section: PresentableSection
    
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
                    VStack(spacing: 10) {
                        ForEach(section.passages) { passage in
                            Text(passage.bookTranslation ?? "")
                                .font(.system(size: 20, weight: .bold))
                            VStack(spacing: 16) {
                                Text(passage.ref)
                                    .fontWeight(.bold)
                                ForEach(passage.verses) { verse in
                                    Text(verse.text)
                                }
                            }
                        }
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

