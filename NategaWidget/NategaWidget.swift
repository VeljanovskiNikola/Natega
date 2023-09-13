//
//  NategaWidget.swift
//  NategaWidget
//
//  Created by Nikola Veljanovski on 26.12.22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    
    @State private var color: UIColor?
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),
                    image: UIImage(named: "placeholder")!,
                    imageName: "Placeholder",
                    color: color)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        // Call getTimeline and return the first entry in the resulting timeline
        getTimeline(in: context) { timeline in
            guard let entry = timeline.entries.first else {
                fatalError("No timeline entries found.")
            }
            completion(entry)
        }
    }

    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let currentDate = Date()
        let copticDate = Date.copticDate()
        let startOfDay = calendar.startOfDay(for: currentDate)
        let nextMidnight = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        let icons = loadJson(from: "icons2023")
        if let dateForToday = icons.first(where: { $0.copticDate == copticDate }) {
            let imageName = dateForToday.saintIcon.first ?? ""
            let entry = SimpleEntry(date: Date(),
                                    image: UIImage(named: imageName) ?? UIImage(named: "placeholder")!,
                                    imageName: imageName,
                                    color: color)
            entries.append(entry)
        } else {
            let entry = SimpleEntry(date: Date(),
                                    image: UIImage(named: "placeholder")!,
                                    imageName: nil,
                                    color: color)
            entries.append(entry)
        }
        let timeline = Timeline(entries: entries,
                                policy: .after(nextMidnight))
        completion(timeline)
    }
    
    private func loadJson(from fileName: String) -> [WidgetData] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("Could not find JSON file")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not read JSON file")
        }
        
        guard let icons = try? JSONDecoder().decode([WidgetData].self,
                                                    from: data) else {
            fatalError("Could not decode JSON file")
        }
        
        return icons
    }
}

struct WidgetData: Decodable {
    let copticDate: String
    let saintIcon: [String]
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let imageName: String?
    var color: UIColor?
}

struct NategaWidgetEntryView : View {
    let date = Date()
    var entry: Provider.Entry
    let color: UIColor

    var body: some View {
        GeometryReader { geometry in
            ZStack {

                Image(uiImage: entry.image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 300, maxHeight: 200)
                    .clipped()
                    .blur(radius: 5)

                Image(uiImage: entry.image)
                    .resizable()
                    .scaledToFill()
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .frame(maxWidth: 180, maxHeight: 180)
                    .scaleEffect(1.1)
                
                GeometryReader { geometry in
                    VStack(alignment: .center) {
                        if let _ = entry.imageName {
                            Text(entry.imageName!)
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.8)
                                .truncationMode(.tail)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .padding(6)
                                .background(Color.black.opacity(0.4))
                                .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .padding(.horizontal, 10)
                                .padding(.bottom, 15)
                        }
                    }
                    .frame(maxWidth: 170, maxHeight: 170, alignment: .bottom)
                }                
            }
            .onAppear {
                print("widget on appear")
            }
            .onDisappear {
                print("widget on disappear")
            }
        }
    }
    
    private var textDate: some View {
        Text(entry.imageName ?? "")
            .fontWeight(.semibold)
            .foregroundColor(.white)
    }
}

struct NategaWidget: Widget {
    let kind: String = "NategaWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: Provider()) { entry in
            NategaWidgetEntryView(entry: entry, color: entry.color ?? .black)
        }
                            .configurationDisplayName("Agios Widget")
                            .description("A Coptic icon on your home screen that updates daily so you never miss a Saint's Feast ever again!")
                            .supportedFamilies([.systemSmall])
    }
}

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    static func copticDate() -> String {
        let calendar = Calendar(identifier: .coptic)
        let date = Date()
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let monthName = calendar.monthSymbols[month - 1]

        return "\(monthName) \(day)"
    }
}
