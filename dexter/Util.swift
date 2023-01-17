//
//  Util.swift
//  dexter
//
//  Created by Dev on 31/12/2022.
//

import SwiftUI
import GameplayKit

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
    public let points: Int
    public var completed: Bool
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
    
    @Published var points = 0.0;
    
    func get_points() -> CGFloat {
        return points
    }
    
    @Published var wood_collected: Bool = false
    @Published var stone_collected: Bool = false
    @Published var gold_collected: Bool = false
    
    func set_opened(chest_type: ChestType) {
        if chest_type == .wood {
            wood_collected = true
        }
        
        if chest_type == .stone {
            stone_collected = true
        }
        
        if chest_type == .gold {
            gold_collected = true
        }
    }
    
    // Collection - collected
    
    struct Card {
        let number: Int
    }
    
    @Published var collected: [Int : Bool] = [
        1: false,
        2: false,
        3: false,
        4: false,
        5: false,
        6: false,
        7: false,
        8: false,
        9: false,
        10: false,
        11: false,
        12: false,
        13: false,
        14: false,
        15: false,
        16: false,
        17: false,
        18: false,
        19: false,
        20: false,
        21: false,
        22: false,
        23: false,
        24: false,
        25: false,
        26: false,
        27: false,
        28: false,
        29: false,
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
                UtilAssignment(title: "Drawing - Sketching Techniques", description: "Practice sketching techniques using the provided worksheets. Submit your sketches by Thursday (14. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 14)!),
                UtilAssignment(title: "Painting - Color Theory", description: "Create a painting using the color wheel and submit it by Saturday (16. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 16)!),
                UtilAssignment(title: "Photography - Composition", description: "Take photographs and submit them by Monday (18. 10. 2023) that demonstrate the principles of composition.", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
                UtilAssignment(title: "Sculpture - Clay Modeling", description: "Create a clay sculpture and submit it by Wednesday (20. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
                UtilAssignment(title: "Art History - Renaissance Art", description: "Research and write a 2-page paper on a chosen Renaissance artist or artwork. Submit it by Friday (22. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 22)!)
            ],
            "biology":  [
                UtilAssignment(title: "Cell Biology - Mitosis and Meiosis", description: "Read chapter 2 of 'Biology' textbook and complete exercises 2.1-2.3. Submit your work by Thursday (14. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 14)!),
                UtilAssignment(title: "Ecology - Food Webs and Energy Flow", description: "Watch the Khan Academy video on ecology and complete the related practice problems. Submit your work by Saturday (16. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 16)!),
                UtilAssignment(title: "Genetics - Inheritance and Traits", description: "Read chapter 4 of 'Biology' textbook and complete exercises 4.1-4.2. Submit your work by Monday (18. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
                UtilAssignment(title: "Evolution - Natural Selection", description: "Watch the Khan Academy video on evolution and complete the related practice problems. Submit your work by Wednesday (20. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
                UtilAssignment(title: "Anatomy - The Muscular System", description: "Read chapter 7 of 'Biology' textbook and complete exercises 7.1-7.3. Submit your work by Friday (22. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 22)!)
            ],
            "chemistry":  [
                UtilAssignment(title: "Atomic Structure - Electron Configuration", description: "Read chapter 2 of 'Chemistry' textbook and complete exercises 2.1-2.3. Submit your work by Thursday (14. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 14)!),
                UtilAssignment(title: "Thermochemistry - Enthalpy and Entropy", description: "Watch the Khan Academy video on thermochemistry and complete the related practice problems. Submit your work by Saturday (16. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 16)!),
                UtilAssignment(title: "Chemical Bonding - Ionic and Covalent Bonds", description: "Read chapter 4 of 'Chemistry' textbook and complete exercises 4.1-4.2. Submit your work by Monday (18. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
                UtilAssignment(title: "Acid-Base Chemistry - pH and pOH", description: "Watch the Khan Academy video on acid-base chemistry and complete the related practice problems. Submit your work by Wednesday (20. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
                UtilAssignment(title: "Periodic Table - Element Properties", description: "Research and write a 2-page paper on a chosen element, including its properties, uses, and historical significance.)", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
            ],
            "english":  [
                UtilAssignment(title: "Literary Analysis - Symbolism in 'The Great Gatsby'", description: "Read chapter 2 of 'The Great Gatsby' and write a 2-page paper on the symbolism in the novel. Submit your paper by Thursday (14. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 14)!),
                UtilAssignment(title: "Creative Writing - Short Story", description: "Write a short story and submit it by Saturday (16. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 16)!),
                UtilAssignment(title: "Grammar Review - Comma Usage", description: "Complete the comma usage exercises in the back of the grammar textbook and submit your work by Monday (18. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
                UtilAssignment(title: "Poetry - Sonnet Writing", description: "Write a sonnet and submit it by Wednesday (20. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
                UtilAssignment(title: "Essay Writing - Persuasive Writing", description: "Write a 2-page persuasive essay on a chosen topic and submit it by Friday (22. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 22)!)
            ],
            "geography":  [
                UtilAssignment(title: "Physical Geography - Plate Tectonics", description: "Read chapter 2 of 'Physical Geography' textbook and complete exercises 2.1-2.3. Submit your work by Thursday (14. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 14)!),
                UtilAssignment(title: "Human Geography - Demographics", description: "Research and write a 2-page paper on the demographics of a chosen city. Include information about population, age, race, and income. Submit your paper by Saturday (16. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 16)!),
                UtilAssignment(title: "Environmental Geography - Climate Change", description: "Watch the TED talk on climate change and write a 1-page reflection on the causes and effects of climate change. Submit your reflection by Monday (18. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
                UtilAssignment(title: "Economic Geography - Globalization", description: "Read chapter 4 of 'Economic Geography' textbook and complete exercises 4.1-4.2. Submit your work by Wednesday (20. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
                UtilAssignment(title: "Political Geography - Borders and Boundaries", description: "Research and write a 2-page paper on the history and significance of a chosen international border or boundary. Submit your paper by Friday (22. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 22)!)
            ],
            "history":  [
                UtilAssignment(title: "Ancient Egypt", description: "Research and write a 2-page paper on the social hierarchy of ancient Egypt. Include information about pharaohs, nobles, and commoners. Submit your paper by Friday (22. 10. 2023).", points: 75, completed: false, score: 0, due_date: Date.from(year: 2023, month: 4, day: 22)!),
                UtilAssignment(title: "Ancient Greece", description: "Watch the documentary 'Greece: Secrets of the Past' and answer the following questions in a 1-page essay: How did the geography of Greece shape its culture and society? How did the city-state of Athens become a dominant power in ancient Greece? Submit your essay by Monday (25. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 4, day: 25)!),
                UtilAssignment(title: "Roman Republic and Empire", description: "Read 'The Roman Republic' by W.W. Tarn and 'The Roman Empire' by M.I. Finley. Write a 3-page paper comparing and contrasting the two political systems. Submit your paper by Wednesday (27. 10. 2023).", points: 100, completed: false, score: 0, due_date: Date.from(year: 2023, month: 4, day: 27)!),
                UtilAssignment(title: "Medieval Europe", description: "Research and create a presentation on the Black Death and its impact on medieval Europe. Include information about the causes, spread, and consequences of the plague. Submit your presentation by Friday (29. 10. 2023).", points: 75, completed: false, score: 0, due_date: Date.from(year: 2023, month: 4, day: 29)!),
                UtilAssignment(title: "Renaissance and Reformation", description: "Read 'The Renaissance' by J.H. Plumb and 'The Reformation' by Diarmaid MacCulloch. Write a 2-page paper discussing the impact of these movements on society and culture in Europe. Submit your paper by Monday (1. 11. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 11, day: 1)!),
                UtilAssignment(title: "Age of Exploration", description: "Research and write a 3-page paper on the impact of the Age of Exploration on global trade and cultural exchange. Include information about key explorers and the effects of their voyages. Submit your paper by Wednesday (3. 11. 2023).", points: 100, completed: false, score: 0, due_date: Date.from(year: 2023, month: 11, day: 3)!),
                UtilAssignment(title: "Colonial America", description: "Research and create a presentation on the causes and consequences of the American Revolution. Include information about key figures, events, and the impact on the colonies and Britain. Submit your presentation by Friday (5. 11. 2023).", points: 75, completed: false, score: 0, due_date: Date.from(year: 2023, month: 11, day: 5)!),
                UtilAssignment(title: "French Revolution", description: "Read 'The French Revolution' by J.M. Roberts and 'The Reign of Terror' by J.M. Submit your presentation by Friday (5. 11. 2023).", points: 75, completed: false, score: 0, due_date: Date.from(year: 2023, month: 11, day: 6)!),
            ],
            "math":  [
                UtilAssignment(title: "Algebra 1 - Solving Linear Equations", description: "Read chapter 2 of 'Algebra 1' textbook and complete exercises 2.1-2.5. Submit your work by Thursday (14. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 14)!),
                UtilAssignment(title: "Calculus 1 - Limits", description: "Watch the Khan Academy video on limits and complete the related practice problems. Submit your work by Saturday (16. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 16)!),
                UtilAssignment(title: "Geometry 2 - Congruent Triangles", description: "Read chapter 4 of 'Geometry 2' textbook and complete exercises 4.1-4.3. Submit your work by Monday (18. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
                UtilAssignment(title: "Trigonometry - Sine, Cosine, and Tangent", description: "Watch the Khan Academy video on trigonometry and complete the related practice problems. Submit your work by Wednesday (20. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
                UtilAssignment(title: "Precalculus - Logarithms", description: "Read chapter 7 of 'Precalculus' textbook and complete exercises 7.1-7.3. Submit your work by Friday (22. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 22)!)
            ],
            "pe":  [
                UtilAssignment(title: "Fitness Challenge", description: "Complete a fitness challenge of your choice (e.g. run a 5k, do 100 push-ups in a row) and submit a video or photo as proof by Friday (15. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 15)!),
                UtilAssignment(title: "Team Sports", description: "Participate in a team sport (e.g. basketball, soccer) and submit a summary of your performance by Monday (18. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
                UtilAssignment(title: "Individual Sports", description: "Participate in an individual sport (e.g. tennis, swimming) and submit a summary of your performance by Wednesday (20. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
                UtilAssignment(title: "Fitness Program Design", description: "Design a fitness program for yourself or a fictional client, including goals, exercises, and a schedule. Submit by Friday (22. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 22)!),
                UtilAssignment(title: "Physical Education Reflection", description: "Reflect on a physical activity you participated in this week and write a 1-page paper discussing the physical, mental, and emotional benefits you experienced. Submit by Monday (25. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 25)!)
            ],
            "physics":  [
                UtilAssignment(title: "Classical Mechanics - Newton's Laws", description: "Read chapter 2 of 'Classical Mechanics' textbook and complete exercises 2.1-2.3. Submit your work by Thursday (14. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 14)!),
                UtilAssignment(title: "Waves and Optics - Reflection and Refraction", description: "Watch the Khan Academy video on reflection and refraction and complete the related practice problems. Submit your work by Saturday (16. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 16)!),
                UtilAssignment(title: "Thermodynamics - Laws of Thermodynamics", description: "Read chapter 4 of 'Thermodynamics' textbook and complete exercises 4.1-4.2. Submit your work by Monday (18. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
                UtilAssignment(title: "Electromagnetism - Electric Fields and Potential", description: "Watch the Khan Academy video on electric fields and potential and complete the related practice problems. Submit your work by Wednesday (20. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
                UtilAssignment(title: "Quantum Mechanics - Wave-Particle Duality", description: "Read chapter 7 of 'Quantum Mechanics' textbook and complete exercises 7.1-7.2. Submit your work by Friday (22. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 22)!)
            ],
            "spanish":  [
                UtilAssignment(title: "Verb Conjugation", description: "Conjugate the following verbs in the present tense: hablar, comer, vivir. Submit your work by Thursday (14. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 14)!),
                UtilAssignment(title: "Translation", description: "Translate the following sentence from English to Spanish: 'I am going to the store.' Submit your work by Saturday (16. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 16)!),
                UtilAssignment(title: "Culture", description: "Research and write a 2-page paper on a famous Spanish-speaking artist or musician. Include information about their life, work, and cultural significance. Submit your paper by Monday (18. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
                UtilAssignment(title: "Conversation", description: "Have a 5-minute conversation with a native Spanish speaker and submit a summary of the conversation by Wednesday (20. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
                UtilAssignment(title: "Grammar Review", description: "Complete the grammar review exercises in the back of the textbook, chapters 1-3. Submit your work by Friday (22. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 22)!)
            ],
            "music":  [
                UtilAssignment(title: "Music Theory - Note Values and Time Signatures", description: "Read chapter 2 of 'Music Theory' textbook and complete exercises 2.1-2.3. Submit your work by Thursday (14. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 14)!),
                UtilAssignment(title: "Composition - Melody Writing", description: "Write a short melody in the key of C major using the notes provided and submit a recording of you performing it by Saturday (16. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 16)!),
                UtilAssignment(title: "Music History - Baroque Period", description: "Read chapter 4 of 'Music History' textbook and complete exercises 4.1-4.2. Submit your work by Monday (18. 10. 2023).", points: 15, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 18)!),
                UtilAssignment(title: "Instrumental Technique - Scales and Arpeggios", description: "Practice and perform scales and arpeggios on your instrument and submit a recording by Wednesday (20. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 20)!),
                UtilAssignment(title: "Ear Training - Interval Recognition", description: "Practice interval recognition using online ear training exercises and submit a screenshot of your progress by Friday (22. 10. 2023).", points: 10, completed: false, score: 0, due_date: Date.from(year: 2023, month: 3, day: 22)!)
            ]
        ]

    @Published var selected_assignment: Int = -1

    // Chest - selected
    
    enum ChestViewPage {
        case start
        case card1
        case card2
        case card3
    }

    @Published var chest_to_open: ChestType = .wood
    @Published var chest_page_current: ChestViewPage = .start
    @Published var card_from_chest: Int = 0
    
    @Published var cards_collected_from_chest: [Int] = [0, 0, 0]
    
    func chest_page_next() {
        let current = chest_page_current
        
        if current == .start {
            card_from_chest = calculate_card_from_chest(chest_to_open: chest_to_open)
            cards_collected_from_chest[0] = card_from_chest
            collected[card_from_chest] = true
            chest_page_current = .card1
        }
        
        if current == .card1 {
            card_from_chest = calculate_card_from_chest(chest_to_open: chest_to_open)
            
            while (true) {
                for card in cards_collected_from_chest {
                    print("Collected: " + String(card) + " Current: " + String(card_from_chest))
                    if card_from_chest == card {
                        card_from_chest = calculate_card_from_chest(chest_to_open: chest_to_open)
                    }
                }
                break
            }
            
            cards_collected_from_chest[1] = card_from_chest
            collected[card_from_chest] = true
            chest_page_current = .card2
        }
        
        if current == .card2 {
            card_from_chest = calculate_card_from_chest(chest_to_open: chest_to_open)
            
            while (true) {
                for card in cards_collected_from_chest {
                    print("Collected: " + String(card) + " Current: " + String(card_from_chest))
                    if card_from_chest == card {
                        card_from_chest = calculate_card_from_chest(chest_to_open: chest_to_open)
                    }
                }
                break
            }
            
            cards_collected_from_chest[2] = card_from_chest
            collected[card_from_chest] = true
            chest_page_current = .card3
        }
        
        if current == .card3 {
            card_from_chest = 0
            cards_collected_from_chest = [0, 0, 0]
            chest_page_current = .start
            util.set_opened(chest_type: chest_to_open)
            util.set_page(_page: .home)
        }
    }
    
    func calculate_card_from_chest(chest_to_open: ChestType) -> Int {
        if chest_to_open == .wood {
            let random = GKRandomSource()
            let dice3d6 = GKRandomDistribution(randomSource: random, lowestValue: 16, highestValue: 30)
            return dice3d6.nextInt()
        }
        
        if chest_to_open == .stone {
            let random = GKRandomSource()
            let dice3d6 = GKRandomDistribution(randomSource: random, lowestValue: 7, highestValue: 20)
            return dice3d6.nextInt()
        }
        
        if chest_to_open == .gold {
            let random = GKRandomSource()
            let dice3d6 = GKGaussianDistribution(randomSource: random, lowestValue: 1, highestValue: 15)
            return dice3d6.nextInt()
        }
        
        return 0
    }
    
}
