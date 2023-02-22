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
    
    let readingsCase: LoadReadingsUseCaseType
    var nextColors: UIImageColors?
    var colors: [Color] {
        [
            Color(uiColor: backgroundColor.withAlphaComponent(0.3)),
            Color(uiColor: backgroundColor)
        ]
    }
    
    // Published properties
    @Published var presentableSections: [PresentableSection] = []
    @Published var sections: [Section] = []
    @Published var synaxars: [Reading] = []
    @Published var readings: Feast?
    @Published var presentablePassages: [Passage] = []
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
                    self.backgroundColor = nextBackgroundColor
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
    init(readingsCase: LoadReadingsUseCaseType) {
        self.readingsCase = readingsCase
//        self.setupColors()
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
        self?.setSynaxars()
        self?.setPassages()
        self?.setPresentableSections()
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
    
    //    private func setupColors() {
    
    //        if imageNames.count > 0 {
    //            UIImage(imageLiteralResourceName: imageNames[0]).getColors { [weak self] colors in
    //                self?.backgroundColor = colors?.background ?? UIColor()
    //                self?.primaryColor = colors?.primary ?? UIColor()
    //                self?.secondaryColor = colors?.secondary ?? UIColor()
    //                self?.detailColor = colors?.detail ?? UIColor()
    //                self?.previousBackgroundColor = self?.backgroundColor ?? UIColor()
    //                self?.previousPrimaryColor = self?.primaryColor ?? UIColor()
    //                self?.previousSecondaryColor = self?.secondaryColor ?? UIColor()
    //                self?.previousDetailColor = self?.detailColor ?? UIColor()
    //            }
    //            nextColors = UIImage(imageLiteralResourceName: imageNames[safeIndex: 1] ?? "Archangel Michael").getColors()
    //            nextBackgroundColor = nextColors?.background ?? UIColor()
    //            nextPrimaryColor = nextColors?.primary ?? UIColor()
    //            nextSecondaryColor = nextColors?.secondary ?? UIColor()
    //            detailColor = nextColors?.detail ?? UIColor()
    //        }
    //    }
    
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
    
    var copticDate: String {
        var text = Date.copticDate()
        let modifiedText = text.split(separator: ",")
        text = String(modifiedText[0])
        return text
    }
    
    private func update(state: State) {
        self.state = state
    }
        
    enum State {
        case loading
        case ready
    }
    
    private func setSynaxars() {
        let sections = readings.map { $0.sections }
        let liturgy = sections?.first(where: { $0.title == "Liturgy" })
        let synaxars = liturgy?.subSections.first(where: { $0.title == "Synaxarium" })
        let readings = synaxars?.readings
        self.synaxars = readings ?? []
    }
    
    private func setPassages() {
        let sections = readings.map { $0.sections }
        let matins = sections?.first(where: { $0.title == "Matins" })
        let matinsSubSection = matins?.subSections.first(where: { $0.id == 1 })
        let matinsReadings = matinsSubSection?.readings.first(where: { $0.id == 2 })
        if let matinsPassage = matinsReadings?.passages?.first {
            self.presentablePassages.append(matinsPassage)
        }
        let liturgy = sections?.first(where: { $0.title == "Liturgy" })
        if let liturgyPassages = liturgy?.subSections.flatMap({ $0.readings }).compactMap({ $0.passages }).flatMap({ $0 }) {
            presentablePassages = presentablePassages + liturgyPassages
        }
        let vespers = sections?.first(where: { $0.title == "Vespers" })
        if let vesperPassages = vespers?.subSections.flatMap({ $0.readings }).compactMap({ $0.passages }).flatMap({ $0 }) {
            presentablePassages = presentablePassages + vesperPassages
        }
    }
    
    private func setPresentableSections() {
        let sections = readings.map { $0.sections }
        self.sections = sections ?? []
        sections?.forEach({ section in
            let subSections = section.subSections.filter { $0.title != "Synaxarium" }
            let psalmAndGospels = section.subSections.filter { $0.title == "Psalm & Gospel" }
            let final = subSections.filter { $0.title != "Psalm & Gospel" }
            if psalmAndGospels.count > 0 {
                psalmAndGospels.forEach { pg in
                    let passages = pg.readings.flatMap { $0.passages ?? [] }
                    presentableSections.append(PresentableSection(passages: passages,
                                                                  subSectionTitle: pg.title ?? "",
                                                                  title: section.title ?? ""))
                }
            }
            final.forEach { subSection in
                 subSection.readings.forEach({
                     let passages = $0.passages
                     presentableSections.append(PresentableSection(passages: passages ?? [],
                                                                   subSectionTitle: subSection.title ?? "",
                                                                   title: section.title ?? ""))
                 })
            }
        })
    }
    
    func hasOneName(for section: PresentableSection) -> Bool {
        section.passages.dropFirst().allSatisfy({ $0.bookTranslation == section.passages.first?.bookTranslation })
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
