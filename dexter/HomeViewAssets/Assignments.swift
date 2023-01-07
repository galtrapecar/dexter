//
//  Assignments.swift
//  dexter
//
//  Created by Dev on 07/01/2023.
//

import SwiftUI

struct Assignment: View  {
    var subject: String
    var abbreviation: String
    var points: String
    var time_left: String
    var is_white: Bool
    
    var title: String
    var description: String
    
    private let font_size: CGFloat = 8
    
    var body: some View {
        GeometryReader { metrics in
            HStack {
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
                        .lineLimit(2)
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
                Assignment(subject: "math", abbreviation: "MAT", points: "50", time_left: "1 day",
                           is_white: true,
                           title: "GEOMETRY 1 - Pythagorean theorem basics",
                           description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023)."
                )
                Assignment(subject: "chemistry", abbreviation: "CHEM", points: "40", time_left: "2 days",
                           is_white: false,
                           title: "GEOMETRY 1 - Pythagorean theorem basics",
                           description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).")
                Assignment(subject: "history", abbreviation: "HIS", points: "40", time_left: "2 days",
                           is_white: true,
                           title: "GEOMETRY 1 - Pythagorean theorem basics",
                           description: "Open “NEW ELEMENTARY MATHEMATICS” on page 137 and do exercises 17, 18, 19a 23, 24 and 27 (examples a. - g.). Submit your work by Tuesday (12. 10. 2023).")
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
        RootView().environmentObject(Util())
    }
}
