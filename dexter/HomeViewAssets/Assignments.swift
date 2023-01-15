//
//  Assignments.swift
//  dexter
//
//  Created by Dev on 07/01/2023.
//

import SwiftUI

struct AssignmentView: View  {
    var subject: String
    var abbreviation: String
    var points: String
    var time_left: String
    var is_white: Bool
    var completed: Bool
    
    var title: String
    var description: String
    
    var line_limit: Int
    
    private let font_size: CGFloat = 8
    
    func calculate_status() -> String {
        if (completed) {
            return "Done"
        }
        if (!completed && time_left == "0 days") {
            return "Failed"
        }
        return "To Do"
    }
    
    var body: some View {
        GeometryReader { metrics in
            HStack(spacing: -5) {
                // Left card
                VStack(alignment: .leading) {
                    
                    // Abbreviation
                    Text(abbreviation)
                        .fontWeight(.bold)
                        .foregroundColor(is_white ? Color.white : Color.black)
                    
                    // Points
                    HStack(spacing: 2) {
                        Text("Points:")
                            .font(
                                .system(
                                    size: font_size,
                                    weight: .bold
                                )
                            )
                            .foregroundColor(is_white ? Color.white : Color.black)
                        Text(points)
                            .font(
                                .system(
                                    size: font_size,
                                    weight: .regular
                                )
                            )
                            .foregroundColor(is_white ? Color.white : Color.black)
                    }
                
                    // Time left
                    HStack(spacing: 2) {
                        Text("Time left:")
                            .font(
                                .system(
                                    size: font_size,
                                    weight: .bold
                                )
                            )
                            .foregroundColor(is_white ? Color.white : Color.black)
                        Text(time_left)
                            .font(
                                .system(
                                    size: font_size,
                                    weight: .regular
                                )
                            )
                            .foregroundColor(is_white ? Color.white : Color.black)
                    }
                    
                    // Status
                    HStack(spacing: 2) {
                        Text("Status:")
                            .font(
                                .system(
                                    size: font_size,
                                    weight: .bold
                                )
                            )
                            .foregroundColor(is_white ? Color.white : Color.black)
                        Text(calculate_status())
                            .font(
                                .system(
                                    size: font_size,
                                    weight: .regular
                                )
                            )
                            .foregroundColor(is_white ? Color.white : Color.black)
                    }
                }
                .padding([.top, .leading], -10.0)
                .frame(
                    width: (metrics.size.width * 0.34) - 20.0,
                    height: metrics.size.height - 10.0
                )
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color(subject))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .strokeBorder(.black, lineWidth: 3.0)
                        .opacity(0.2)
                )
                
                Spacer()
                    .frame(
                        width: 20.0
                    )
                
                // Right card
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(title)
                        .font(
                            .system(
                                size: 9,
                                weight: .bold
                            )
                        )
                        .foregroundColor(Color.black)
                    
                    Text(description)
                        .font(
                            .system(
                                size: 9,
                                weight: .regular
                            )
                        )
                        .foregroundColor(Color.black.opacity(0.5))
                        .lineLimit(line_limit)
                }
                .padding(.all, 10.0)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: metrics.size.height - 10.0,
                    alignment: .topLeading
                )
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .strokeBorder(.black, lineWidth: 3.0)
                )
            }
            .frame(
                width: metrics.size.width,
                height: metrics.size.height,
                alignment: .leading
            )
        }
    }
}

struct Assignments: View {
    var body: some View {
        VStack {
            VStack {
                AssignmentView(subject: "math", abbreviation: "MAT", points: "50", time_left: "1 day",
                           is_white: true,
                               completed: false, title: "GEOMETRY 1 - Pythagorean theorem basics",
                               description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", line_limit: 2
                )
                AssignmentView(subject: "chemistry", abbreviation: "CHEM", points: "40", time_left: "2 days",
                               is_white: false, completed: false,
                           title: "GEOMETRY 1 - Pythagorean theorem basics",
                           description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", line_limit: 2)
                AssignmentView(subject: "history", abbreviation: "HIS", points: "40", time_left: "2 days",
                               is_white: true, completed: false, title: "GEOMETRY 1 - Pythagorean theorem basics",
                           description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).", line_limit: 2)
            }
            .padding(.bottom, 130.0)
            .padding(.horizontal, 20.0)
            .padding(.top, 20.0)
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height * 0.5
        )
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial)
                .opacity(0.2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white, lineWidth: 0.4)
                .opacity(0.7)
        )
    }
}

struct Assignments_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Util())
    }
}
