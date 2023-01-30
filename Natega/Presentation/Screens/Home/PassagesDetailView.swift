//
//  PassagesDetailView.swift
//  Natega
//
//  Created by Nikola Veljanovski on 30.1.23.
//

import SwiftUI

struct PassagesDetailView: View {
    let passage: Passage?
    
    var body: some View {
            VStack {
                VStack {
                    Text("Psalms: \(passage?.ref ?? "")")
                    Text("Gospel: \(passage?.ref ?? "")")
                }
                .font(.system(.headline))
                
                ScrollView {
                    ForEach(passage?.verses ?? []) { verse in
                        Text(verse.text)
                            .padding(.horizontal, 16)
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 2)
        }
    }
}

