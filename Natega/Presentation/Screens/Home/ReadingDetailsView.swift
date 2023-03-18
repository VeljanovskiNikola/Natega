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
                            HStack(spacing: 10) {
                                
                                Text(passage.bookTranslation ?? "")
                                    .font(Font.system(size: 20, design: .rounded).weight(.medium))
                                
                                Text(passage.ref)
                                    .font(Font.system(size: 20, design: .rounded).weight(.medium))
                                
                            }
                            .multilineTextAlignment(.center)
                            
                            VStack(spacing: 16) {
                                ForEach(passage.verses) { verse in
                                    Text(verse.text)
                                        .font(Font.system(size: 20, design: .rounded).weight(.light))
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .padding(.bottom, 24)
                }
            }
            .frame(width: 350)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

