//
//  Util.swift
//  dexter
//
//  Created by Dev on 31/12/2022.
//

import SwiftUI
import FirebaseFirestoreSwift

extension Date {
    // https://stackoverflow.com/a/52704760
    static func from(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
}

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

struct UtilAssignment: Identifiable {
    let id = UUID()
    public let title: String
    public let description: String
    public let ponints: Int
    public let completed: Bool
    public let score: Int
    public let due_date: Date
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
    
    public enum Page {
        case login
        case home
        case chest
        case subject
    }
    
    @Published var page = Page.login
    
    func set_page(_page: Page) {
        page = _page
    }
    
    // Points
    
    @Published var points = 63.0;
    
    func get_points() -> CGFloat {
        return points
    }
    
    // Collection - collected
    
    struct Card {
        let number: Int
    }
    
    @Published var collected: [Int : Bool] = [
        1: false,
        2: true,
        3: true,
        4: false,
        5: true,
        6: true,
        7: false,
        8: true,
        9: true,
        10: true,
        11: true,
        12: false,
        13: true,
        14: false,
        15: false,
        16: true,
        17: true,
        18: false,
        19: true,
        20: true,
        21: false,
        22: false,
        23: false,
        24: true,
        25: true,
        26: true,
        27: true,
        28: false,
        29: true,
        30: false,
    ]
    
    @Published var collection_size: Int = 30
    
    @Published var showing_card: Bool = false
    @Published var showing_card_index: Int = 0
    
    // Settings - user
    
    @Published var username: String = "Janez Primer"
    @Published var nickname: String = "XxGamerxX"
    @Published var email: String = "89211190@student.upr.si"
    @Published var class_: String = "9C"
    
    // Settings - settings
    
    @Published var language: String = "en"
    @Published var notifications: Bool = false
    @Published var sound: Bool = false
    @Published var haptics: Bool = false
    @Published var motion: Bool = false
    
    // Subjects - selected
    
    @Published var selected_subject: String = ""
    
    @Published var assignments: [String : [UtilAssignment]] = [
        "art":  [
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!)
        ],
        "biology":  [
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: true, score: 87, due_date: Date.from(year: 2023, month: 3, day: 18)!),
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: true, score: 100, due_date: Date.from(year: 2023, month: 3, day: 18)!),
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: true, score: 96, due_date: Date.from(year: 2023, month: 3, day: 18)!)
        ],
        "chemistry":  [
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!)
        ],
        "english":  [
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!)
        ],
        "geography":  [
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!)
        ],
        "history":  [
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!)
        ],
        "math":  [
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!)
        ],
        "pe":  [
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!)
        ],
        "physics":  [
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!)
        ],
        "spanish":  [
            UtilAssignment(title: "GEOMETRY 1 - Pythagorean theorem basics", description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a, 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", ponints: 50, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!)
        ]
    ]

    // Chest - selected

    @Published var chest_to_open: ChestType = .wood
}
