//
//  AppCompositionRoot.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.12.22.
//

import SwiftUI

final class AppCompositionRoot {
    static let assembler = DefaultAssembler()
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    static var start: some View {
        assembler.resolve()
    }
}
