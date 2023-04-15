//
//  NategaWidget.swift
//  NategaWidget
//
//  Created by Nikola Veljanovski on 26.12.22.
//

import WidgetKit
import SwiftUI
import Intents
import UIImageColors

struct Provider: TimelineProvider {
    
    @State private var color: UIColor?
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),
                    image: UIImage(named: "stmary")!,
                    imageName: "Saint Mary",
                    color: color)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(),
                                image: UIImage(named: "placeholder")!,
                                imageName: "placeholder",
                                color: color)
        completion(entry)
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
            let imageColors = UIImage(named: imageName)?.getColors()
            color = imageColors?.background
            let entry = SimpleEntry(date: Date(),
                                    image: UIImage(named: imageName) ?? UIImage(named: "placeholder")!,
                                    imageName: imageName,
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
    let imageName: String
    var color: UIColor?
}

struct NategaWidgetEntryView : View {
    let date = Date()
    var entry: Provider.Entry
    let color: UIColor
    
    var body: some View {
        ZStack {
            Image(uiImage: entry.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 300, maxHeight: 200)
                .clipped()
                .offset(y: 15)
        
            textDate
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.vertical, 5)
                .padding(.horizontal, 8)
                .cornerRadius(12)
                .background(
                    Rectangle()
                        .fill(Color(uiColor: color).opacity(0.5)))
                .cornerRadius(12)
                .padding(.top, 100)
                .padding(.horizontal, 8)
        }
        .onAppear {
            print("widget on appear")
        }
        .onDisappear {
            print("widget on disappear")
        }
    }
    
    private var textDate: some View {
        Text(entry.imageName)
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
                            .configurationDisplayName("Natega Widget")
                            .description("Showing the current feast")
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
