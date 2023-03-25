//
//  ReadingsView.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.3.23.
//

import SwiftUI

struct ReadingSection: View {
    let presentableSection: PresentableSection
    let hasOneName: Bool
    
    var body: some View {
        VStack {
            if hasOneName {
                Text("\(presentableSection.passages.first?.bookTranslation ?? "")")
                HStack(spacing: 3) {
                    ForEach(presentableSection.passages) { passage in
                        if presentableSection.passages.count > 1 {
                            if passage == presentableSection.passages.last {
                                Text(passage.ref)
                            } else {
                                Text(passage.ref)
                                Text("&")
                            }
                        } else {
                            Text("\(passage.ref)")
                                .lineLimit(1)
                        }
                    }
                }
                .minimumScaleFactor(0.5)


                Text("\(presentableSection.subSectionTitle) ∘ \(presentableSection.title)")
                    .font(.caption2)
                    .padding(.top, -5)
            } else {
                ForEach(presentableSection.passages) { passage in
                    Text("\(passage.bookTranslation ?? "") \(passage.ref)")
                }
                Text("\(presentableSection.subSectionTitle) ∘ \(presentableSection.title)")
                    .font(.caption2)
                    .padding(.top, -5)
            }
        }
        .foregroundColor(.white)
        .font(.system(size: 18, weight: .regular, design: .rounded))
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(Color.randomDarkColor())
        .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .frame(maxWidth: 200, maxHeight: 100)
        .shadow(color: Color.shadow.opacity(0.7), radius: 5, x: 0, y: 10)
        .padding()
    }
}

