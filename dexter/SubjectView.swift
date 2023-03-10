//
//  SubjectView.swift
//  dexter
//
//  Created by Gal Trapecar on 14/01/2023.
//

import SwiftUI

private struct AssignmentIndex {
    static private var index: Int = 1
    
    static func get_index() -> Int {
        self.index = self.index + 1
        return self.index - 1
    }
    
    // Gets index without incrementing
    static func get_index_safe() -> Int {
        return self.index
    }
    
    static func reset() {
        self.index = 1
    }
}

struct AssignmentsView: View {
    let subject: String
    let assignments: [UtilAssignment]
    
    var body: some View {
        ForEach(assignments, id: \.id) { _assignment in
            AssignmentView(subject: _assignment.completed ? "completed" : subject, abbreviation: String(AssignmentIndex.get_index()), points: String(_assignment.points), time_left: "2 days",
                       is_white: false,
                           completed: _assignment.completed,
                           title: _assignment.title,
                           description: _assignment.description, line_limit: 3)
            .frame(height: 90)
        }
        .onAppear {
            AssignmentIndex.reset()
        }
    }
}

struct SubjectView: View {
    @EnvironmentObject var util: Util
    
    func calculate_completed(assignments: [UtilAssignment]) -> Int {
        var count = 0
        for assignment in assignments {
            if assignment.completed {
                count = count + 1
            }
        }
        return count
    }
    
    func calculate_average_score(assignments: [UtilAssignment]) -> Int {
        var score = 0
        for assignment in assignments {
            if assignment.completed {
                score = score + assignment.score
            }
        }
        let average = Float(score) / Float(assignments.count)
        return average.isNaN ? 0 : Int(average)
    }
    
    var body: some View {
        ZStack {
            Image("forest1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            if (util.selected_assignment == -1) {
                VStack {
                    // Title
                    ZStack {
                        VStack {
                            Button("BACK") {
                                util.set_page(_page: .home)
                            }
                            .foregroundColor(.black)
                            .font(
                                .system(
                                    size: 14,
                                    weight: .bold
                                )
                            )
                            .padding(5)
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Theme.yellow)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .strokeBorder(.black, lineWidth: 2)
                            )
                        }
                        .padding(.leading, 20)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .leading
                        )
                        
                        Text(util.selected_subject)
                            .foregroundColor(.black)
                            .font(
                                .system(
                                    size: 23,
                                    weight: .bold
                                )
                            )
                            .textCase(.uppercase)
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 70
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.ultraThinMaterial)
                            .opacity(0.7)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.white)
                            .opacity(0.6)
                    )
                    
                    // Data
                    
                    VStack(spacing: 10) {
                        // Row 1
                        HStack {
                            // Due
                            HStack(spacing: 2) {
                                Text("Assignments Due: ")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 10, weight: .bold
                                        )
                                    )
                                Text(String(util.assignments[util.selected_subject]?.count ?? 0))
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 10, weight: .semibold
                                        )
                                    )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            //
                            HStack(spacing: 2) {
                                Text("Assignments Completed: ")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 10, weight: .bold
                                        )
                                    )
                                Text(String(calculate_completed(assignments: util.assignments[util.selected_subject] ?? [])))
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 10, weight: .semibold
                                        )
                                    )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        // Row 2
                        HStack {
                            // Due
                            HStack(spacing: 2) {
                                Text("Average Score: ")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 10, weight: .bold
                                        )
                                    )
                                Text(String(calculate_average_score(assignments: util.assignments[util.selected_subject] ?? [])) + "%")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 10, weight: .semibold
                                        )
                                    )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            //
                            HStack(spacing: 2) {
                                Text("Average grade: ")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 10, weight: .bold
                                        )
                                    )
                                Text("0")
                                    .foregroundColor(.black)
                                    .font(
                                        .system(
                                            size: 10, weight: .semibold
                                        )
                                    )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(20)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .topLeading
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.ultraThinMaterial)
                            .opacity(0.7)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.white)
                            .opacity(0.6)
                    )
                    
                    ScrollView {
                        VStack {
                            // Assignments
                            AssignmentsView(subject: util.selected_subject, assignments: util.assignments[util.selected_subject] ?? [])
                        }
                        .frame(
                            maxHeight: .infinity
                        )
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                }
                .padding(20)
                .padding(.top, 50)
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height,
                    alignment: .top
                )
            } else {
                VStack {
                    // Title of selected assignment
                    ZStack {
                        VStack {
                            Button("BACK") {
                                AssignmentIndex.reset()
                                util.selected_assignment = -1
                            }
                            .foregroundColor(.black)
                            .font(
                                .system(
                                    size: 14,
                                    weight: .bold
                                )
                            )
                            .padding(5)
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Theme.yellow)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .strokeBorder(.black, lineWidth: 2)
                            )
                        }
                        .padding(.leading, 20)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .leading
                        )
                        
                        Text(util.selected_subject + " ASSIGNMENT " + String(util.selected_assignment))
                            .foregroundColor(.black)
                            .font(
                                .system(
                                    size: 15,
                                    weight: .bold
                                )
                            )
                            .textCase(.uppercase)
                            .padding(.trailing, 20)
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: 70,
                                alignment: .trailing
                            )
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 70
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.ultraThinMaterial)
                            .opacity(0.7)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.white)
                            .opacity(0.6)
                    )
                    
                    VStack(alignment: .leading) {
                        Text(util.assignments[util.selected_subject]![util.selected_assignment - 1].title)
                            .foregroundColor(.black)
                            .font(
                                .system(
                                    size: 17,
                                    weight: .bold
                                )
                            )
                        
                        Spacer()
                            .frame(
                                maxHeight: 20
                            )
                        
                        Text(util.assignments[util.selected_subject]![util.selected_assignment - 1].description)
                            .foregroundColor(.black)
                            .font(
                                .system(
                                    size: 15,
                                    weight: .regular
                                )
                            )
                    }
                    .padding(20)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.black, lineWidth: 4)
                    )
                    
                    HStack {
                        Button("SUBMIT") {
                            util.assignments[util.selected_subject]![util.selected_assignment - 1].completed = true
                            util.points = util.points + Double(util.assignments[util.selected_subject]![util.selected_assignment - 1].points)
                            util.selected_assignment = -1
                        }
                        .foregroundColor(.black)
                        .font(
                            .system(
                                size: 14,
                                weight: .bold
                            )
                        )
                        .padding(5)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Theme.yellow)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .strokeBorder(.black, lineWidth: 2)
                        )
                        .scaleEffect(1.5)
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                }
                .padding(20)
                .padding(.top, 50)
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height,
                    alignment: .top
                )

            }
            
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        .onAppear {
            AssignmentIndex.reset()
            util.selected_assignment = -1
        }
    }
}

struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView().environmentObject(Util())
    }
}
