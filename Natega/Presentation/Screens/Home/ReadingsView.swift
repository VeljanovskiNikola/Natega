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
                ForEach(presentableSection.passages) { passage in
                    Text(passage.ref)
                }
                Text("\(presentableSection.subSectionTitle) ∘ \(presentableSection.title)")
                    .font(.caption2)
            } else {
                ForEach(presentableSection.passages) { passage in
                    Text("\(passage.bookTranslation ?? "") \(passage.ref)")
                }
                Text("\(presentableSection.subSectionTitle) ∘ \(presentableSection.title)")
                    .font(.caption2)
            }
        }
        .foregroundColor(.white)
        .font(.system(size: 18, weight: .regular))
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .background(Color.randomDarkColor())
        .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Color.shadow.opacity(0.7), radius: 5, x: 0, y: 10)
        .padding()
    }
}

