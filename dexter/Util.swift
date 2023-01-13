//
//  Util.swift
//  dexter
//
//  Created by Dev on 31/12/2022.
//

import SwiftUI

struct Theme {
    static let yellow =     Color("yellow")
    static let dark_gray =  Color("dark_gray")
    static let art =        Color("art")
    static let biology =    Color("biology")
    static let chemistry =  Color("chemistry")
    static let english =    Color("english")
    static let geography =  Color("geography")
    static let history =    Color("history")
    static let math =       Color("math")
    static let music =      Color("music")
    static let pe =         Color("pe")
    static let physics =    Color("physics")
    static let spanish =    Color("spanish")
    
    static func from_string(input: String) -> Color {
        switch input {
        case "yellow" :
            return Theme.yellow
        case "dark_gray" :
            return Theme.dark_gray
        case "art" :
            return Theme.art
        case "biology" :
            return Theme.biology
        case "chemistry" :
            return Theme.chemistry
        case "english" :
            return Theme.english
        case "geography" :
            return Theme.geography
        case "history" :
            return Theme.history
        case "math" :
            return Theme.math
        case "music" :
            return Theme.music
        case "pe" :
            return Theme.pe
        case "physics" :
            return Theme.physics
        case "spanish" :
            return Theme.spanish
        default:
            return Theme.yellow
        }
    }
}

struct Subject {
    static let art =        "art"
    static let biology =    "biology"
    static let chemistry =  "chemistry"
    static let english =    "english"
    static let geography =  "geography"
    static let history =    "history"
    static let math =       "math"
    static let music =      "music"
    static let pe =         "pe"
    static let physics =    "physics"
    static let spanish =    "spanish"
    
    static func abbreviate(subject: String) -> String {
        switch subject {
            case "art":
                return "ART"
            case "biology":
                return "BIO"
            case "chemistry":
                return "CHEM"
            case "english":
                return "ENG"
            case "geography":
                return "GEO"
            case "history":
                return "HIS"
            case "math":
                return "MATH"
            case "music":
                return "MUSIC"
            case "pe":
                return "PE"
            case "physics":
                return "PHYS"
            case "spanish":
                return "SPA"
            default:
                return "ERR"
        }
    }
}

struct FlatGlassView : ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.white)
                            .opacity(0.4)
                    )
                .background(.ultraThinMaterial)
        } else {
            content
        }
    }
}

class Util: ObservableObject {
    public enum Page {
        case login
        case home
        case calendar
        case collection
        case chest
        case settings
        case subject
    }
    
    // Calendar - date
    
    @Published var year: Int = Calendar.current.component(.year, from: Date())
    @Published var month: Int = Calendar.current.component(.month, from: Date())
    @Published var week: Int = Calendar.current.component(.weekOfMonth, from: Date())
    
    func decrease_week() {
        func decrease_month() {
            if (month == 1) {
                year = year - 1
                month = 12
            } else {
                month = month - 1
            }
        }
        
        if (week == 1) {
            decrease_month()
            week = 4
        } else {
            week = week - 1
        }
    }
    
    func increase_week() {
        func increase_month() {
            if (month == 12) {
                year = year + 1
                month = 1
            } else {
                month = month + 1
            }
        }
        
        if (week == 4) {
            increase_month()
            week = 1
        } else {
            week = week + 1
        }
    }
    
    // Calendar - subjects
    
    @Published var monday_subjects:    [String] = ["english", "math", "spanish", "chemistry", "physics", "pe", "pe"]
    @Published var tuesday_subjects:   [String] = ["spanish", "geography", "history", "math", "chemistry"]
    @Published var wednesday_subjects: [String] = ["math", "geography", "physics", "biology", "english"]
    @Published var thursday_subjects:  [String] = ["english", "chemistry", "history", "spanish", "biology", "geography"]
    @Published var friday_subjects:    [String] = ["art", "english", "music", "pe", "pe"]
    
    // Pages
    
    @Published var page = Page.login
    
    func set_page(_page: Page) {
        page = _page
    }
    
    // Points
    
    @Published var points = 63.0;
    
    func get_points() -> CGFloat {
        return points
    }
}
