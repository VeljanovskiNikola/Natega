//
//  SynaxariumDetailView.swift
//  Natega
//
//  Created by Nikola Veljanovski on 30.1.23.
//

import SwiftUI

struct SynaxarDetailView: View {
    let reading: Reading?
    
    var body: some View {
        VStack(spacing: 24) {
            Text(reading?.title ?? "")
                .font(.system(.headline))
            ScrollView {
                Text(reading?.html ?? "")
                    .font(.system(.callout))
            }
            .frame(height: UIScreen.main.bounds.height / 2)
        }
        .padding(.horizontal, 16)
        .multilineTextAlignment(.center)
    }
}
