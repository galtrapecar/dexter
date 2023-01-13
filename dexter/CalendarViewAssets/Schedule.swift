//
//  Calendar.swift
//  dexter
//
//  Created by Gal Trapecar on 13/01/2023.
//

import SwiftUI

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

struct SubjectCard: View {
    var subject: String
    var classroom: String
    var time: String
    var white_text: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: -1.7) {
            Text(Subject.abbreviate(subject: subject))
                .font(
                    .system(
                        size: 13,
                        weight: .bold
                    )
                )
                .foregroundColor(.black)
            
            Text(classroom)
                .font(
                    .system(
                        size: 9,
                        weight: .medium
                    )
                )
                .foregroundColor(.black)
            
            Text(time)
                .font(
                    .system(
                        size: 9,
                        weight: .medium
                    )
                )
                .foregroundColor(.black)
        }
        .padding(6)
        .frame(
            maxWidth: .infinity,
            maxHeight: 50,
            alignment: .topLeading
        )
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Theme.from_string(input: subject))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(.black, lineWidth: 2.0)
                .opacity(0.2)
        )
    }
}

struct SubjectColumn: View {
    @EnvironmentObject var util: Util
    var day: [String]
    
    var body: some View {
        VStack {
            ForEach(0..<day.count) { index in
                buildView(day: day, index: index)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
    }
    
    func buildView(day: [String], index: Int) -> SubjectCard {
        let start = (8 * 60) + 20
        let hour = 50
        var time = start + (index * hour)
        if (index > 0) {
            time = time + 20
        }
        return SubjectCard(subject: day[index], classroom: "17U", time: format(time: time), white_text: false)
        
        func format(time: Int) -> String {
            let hours = Int(floor(Double(time) / 60))
            let minutes = time % 60
            if (String(minutes).count == 1) {
                return String(hours) + ":0" + String(minutes)
            }
            return String(hours) + ":" + String(minutes)
        }
    }
}

struct DayCard: View {
    var day: String
    var this_week: Bool
    
    func is_today() -> Bool {
        var day: Int
        
        switch self.day {
        case "MON":
            day = 1
        case "TUE":
            day = 2
        case "WED":
            day = 3
        case "THU":
            day = 4
        case "FRI":
            day = 5
        default:
            day = 0
        }
        
        if (this_week && day != 0 && Date().dayNumberOfWeek()! - 1 == day) {
            return true
        }
        
        return false
    }
    
    var body: some View {
        VStack {
            ZStack {
                if (is_today()) {
                    Image(systemName: "pin.fill")
                        .resizable()
                        .offset(x: 23, y: -10)
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            maxWidth: 6
                        )
                        .foregroundColor(.black)
                }
                
                Text(day)
                    .font(
                        .system(
                            size: 13,
                            weight: .bold
                        )
                    )
                    .foregroundColor(.black)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Theme.yellow)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(.black, lineWidth: 2.5)
        )
    }
}

struct Schedule: View {
    @EnvironmentObject var util: Util
    
    var body: some View {
        VStack {
            // Day cards
            HStack(spacing: 10) {
                DayCard(day: "MON", this_week: true)
                DayCard(day: "TUE", this_week: true)
                DayCard(day: "WED", this_week: true)
                DayCard(day: "THU", this_week: true)
                DayCard(day: "FRI", this_week: true)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: 40
            )
            
            HStack(spacing: 10) {
                SubjectColumn(day: util.monday_subjects)
                SubjectColumn(day: util.tuesday_subjects)
                SubjectColumn(day: util.wednesday_subjects)
                SubjectColumn(day: util.thursday_subjects)
                SubjectColumn(day: util.friday_subjects)
            }
            .frame(
                height: UIScreen.main.bounds.height * 0.57
            )
            
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(Util())
    }
}
