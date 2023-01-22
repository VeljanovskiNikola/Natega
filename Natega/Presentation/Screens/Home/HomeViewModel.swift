//
//  HomeViewModel.swift
//  Natega
//
//  Created by Nikola Veljanovski on 17.12.22.
//

import Combine
import SwiftUI
import UIImageColors

final class HomeViewModel: ObservableObject {
    
    let synaxarsCase: LoadSynaxarsUseCaseType
    let readingsCase: LoadReadingsUseCaseType
    var nextColors: UIImageColors?
    var colors: [Color] {
        [
            Color(uiColor: backgroundColor.withAlphaComponent(0.3)),
            Color(uiColor: backgroundColor)
        ]
    }
    

    
    // Published properties
    @Published var synaxars: [Synaxar] = []
    @Published var readings: [Reading] = []
    @Published var selectedImage = 0 {
        didSet {
            if oldValue > selectedImage {
                withAnimation(Animation.easeInOut(duration: length)) {
                    backgroundColor = previousBackgroundColor
                    primaryColor = previousPrimaryColor
                    secondaryColor = previousSecondaryColor
                    detailColor = previousDetailColor
                }
            } else {
                withAnimation(Animation.easeInOut(duration: length)) {
                    backgroundColor = nextBackgroundColor
                    primaryColor = nextPrimaryColor
                    secondaryColor = nextSecondaryColor
                    detailColor = nextDetailColor
                }
            }
        }
    }
    @Published var imageNames = ["stmary", "church"]
    @Published var state: State = .loading
    @Published var opacity: CGFloat = 1
    @Published var start = UnitPoint(x: 0.5, y: 0)
    @Published var end = UnitPoint(x: 0.5, y: 1)
    // Private properties
    @Published var backgroundColor: UIColor = .clear
    @Published var primaryColor: UIColor = .clear
    @Published var secondaryColor: UIColor = .clear
    @Published var detailColor: UIColor = .clear
    private var nextBackgroundColor: UIColor = .clear
    private var previousBackgroundColor: UIColor = .clear
    private var nextPrimaryColor: UIColor = .clear
    private var previousPrimaryColor: UIColor = .clear
    private var nextSecondaryColor: UIColor = .clear
    private var previousDetailColor: UIColor = .clear
    private var nextDetailColor: UIColor = .clear
    private var previousSecondaryColor: UIColor = .clear
    private let length : CGFloat = 0.5
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(synaxarsCase: LoadSynaxarsUseCaseType,
         readingsCase: LoadReadingsUseCaseType) {
        self.synaxarsCase = synaxarsCase
        self.readingsCase = readingsCase
        self.setupColors()
    }
    
    func loadSynaxars() {
        synaxarsCase
            .execute()
            .receive(on: RunLoop.main)
            .sink { completion in
                // Intentionally empty
            } receiveValue: { [weak self] synaxars in
                self?.synaxars = synaxars
                self?.update(state: .ready)
            }
            .store(in: &cancellables)
    }
    
    func loadReadings() {
        readingsCase
            .execute()
            .receive(on: RunLoop.main)
            .sink { _ in
                // Intentionally empty
            }
            receiveValue: { [weak self] readings in
                self?.readings = readings
                self?.update(state: .ready)
            }
            .store(in: &cancellables)
    }
    
    func onChange(newValue: Int) {
        nextColors = UIImage(imageLiteralResourceName: imageNames[safeIndex: newValue + 1] ?? "stmary").getColors()
        withAnimation(Animation.easeInOut(duration: length)) {
            nextBackgroundColor = nextColors?.background ?? UIColor()
            nextPrimaryColor = nextColors?.primary ?? UIColor()
            nextSecondaryColor = nextColors?.secondary ?? UIColor()
        }
        
    }

    private func setupColors() {
        if imageNames.count > 0 {
            UIImage(imageLiteralResourceName: imageNames[0]).getColors { [weak self] colors in
                self?.backgroundColor = colors?.background ?? UIColor()
                self?.primaryColor = colors?.primary ?? UIColor()
                self?.secondaryColor = colors?.secondary ?? UIColor()
                self?.detailColor = colors?.detail ?? UIColor()
                self?.previousBackgroundColor = self?.backgroundColor ?? UIColor()
                self?.previousPrimaryColor = self?.primaryColor ?? UIColor()
                self?.previousSecondaryColor = self?.secondaryColor ?? UIColor()
                self?.previousDetailColor = self?.detailColor ?? UIColor()
            }
            nextColors = UIImage(imageLiteralResourceName: imageNames[safeIndex: 1] ?? "stmary").getColors()
            nextBackgroundColor = nextColors?.background ?? UIColor()
            nextPrimaryColor = nextColors?.primary ?? UIColor()
            nextSecondaryColor = nextColors?.secondary ?? UIColor()
            detailColor = nextColors?.detail ?? UIColor()
        }
    }
        
    func formattedDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: date)
        formatter.dateStyle = .long
        return "\(day) " + "\(month)"
    }
    
    private func update(state: State) {
        self.state = state
    }
        
    enum State {
        case loading
        case ready
    }
}

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
